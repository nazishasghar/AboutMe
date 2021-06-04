//
//  AppStateModel.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 03/06/21.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
class AppStateModel : ObservableObject{
    @Published var showingSignIn : Bool = true
    @Published var conversation : [String] = []
    var otherUsername = ""
    @Published var messages : [Message] = []
    @AppStorage("currentUsername") var currentUsername:String = ""
    @AppStorage("currentEmail") var currentEmail:String = ""
    let dataBase = Firestore.firestore()
    let auth = Auth.auth()
    var conversationListener : ListenerRegistration?
    var chatListener : ListenerRegistration?
    init() {
        self.showingSignIn = Auth.auth().currentUser == nil
    }
}

extension AppStateModel{
    func searchUser(queryText: String , completion: @escaping ([String]) -> Void){
            dataBase.collection("users").getDocuments{ snapshot, error in
                guard let usernames = snapshot?.documents.compactMap({$0.documentID}),
                      error == nil else{
                    completion([])
                    return
                }
                let filtered = usernames.filter({$0.lowercased().hasPrefix(queryText.lowercased())})
                completion(filtered)
            }
            
        }
}
extension AppStateModel{
    func getConversation(){
        conversationListener = dataBase.collection("users").document(currentUsername).collection("chats").addSnapshotListener{[weak self] snapshot, error in
            guard let username =  snapshot?.documents.compactMap({$0.documentID}),
                  error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.conversation = username
            }
        }
    }
}
extension AppStateModel{
    func observeChat(){
        createConversation()
               chatListener = dataBase
                   .collection("users")
                   .document(currentUsername)
                   .collection("chats")
                   .document(otherUsername)
                   .collection("messages")
                   .addSnapshotListener{[weak self] snapshot, error in
                    guard let objects =  snapshot?.documents.compactMap({$0.data()}),
                          error == nil else {
                        return
                    }
                       let messages: [Message] = objects.compactMap({
                           guard let date = ISO8601DateFormatter().date(from: $0["created"] as? String ?? "") else {
                               return nil
                           }
                           return Message(text: $0["text"] as? String ?? ""
                                          , type: $0["sender"] as? String == self?.currentUsername ? .sent : .received
                                          , created:date
                           )

                       }).sorted(by: {first, second in
                           return first.created < second.created
                       })
                       
                       
                    DispatchQueue.main.async {
                        self?.messages = messages
                    }

    }
    }
    func sendMessage(text: String){
        let newMessageId = UUID().uuidString
              let dateString = ISO8601DateFormatter().string(from: Date())
              guard !dateString.isEmpty else {
                  print("date string empty")
                  return
              }
              let data = [ "text" : text, "sender" : currentUsername, "created" : dateString]
              dataBase.collection("users").document(currentUsername)
                  .collection("chats")
                  .document(otherUsername)
                  .collection("messages")
                  .document(newMessageId)
                  .setData(data)
              dataBase.collection("users").document(otherUsername)
                  .collection("chats")
                  .document(currentUsername)
                  .collection("messages")
                  .document(newMessageId)
                  .setData(data)

    }
    func createConversation(){
        dataBase.collection("users").document(currentUsername)
                    .collection("chats")
                    .document(otherUsername).setData(["created" : "true"])
                dataBase.collection("users").document(otherUsername)
                    .collection("chats")
                    .document(currentUsername).setData(["created" : "true"])
    }
}
    
    
    
    
extension AppStateModel
{
    func signIn(username: String, password: String){
        dataBase.collection("users").document(username).getDocument { [weak self] snapshot, error in
            guard let email = snapshot?.data()?["email"] as? String, error == nil else{
                return
            }
            self?.auth.signIn(withEmail: email, password: password, completion: { result, error in
                guard error == nil, result != nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.currentEmail = email
                    self?.currentUsername  = username
                    self?.showingSignIn = false
                }
            })
        }
    }
    func signUp(email:String , username: String, password:String){
        auth.createUser(withEmail: email, password: password){[weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            let data = [
                "email": email,
                "username": username
            ]
            self?.dataBase
                .collection("users")
                .document(username)
                .setData(data){error in
                    guard error == nil else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.currentUsername = username
                        self?.currentEmail = email
                        self?.showingSignIn = false
                    }
                }
        }
    }
    
    func signOut(){
            do{
                try auth.signOut()
                self.showingSignIn = true
            }
            catch{
                print(error)
            }
        }
    }
