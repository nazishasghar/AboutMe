//
//  ConversationView.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 03/06/21.
//

import SwiftUI

struct ConversationView: View {
    @EnvironmentObject var model: AppStateModel
    @State var otherUsername : String = ""
    @State var showChat = false
    @State var showSearch = false
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                ForEach(model.conversation, id: \.self) {name in
                    NavigationLink(
                        destination: ChatView(otherUsername: name),
                        label: {
                            HStack{
                                Circle().foregroundColor(.pink)
                                    .frame(width: 65, height: 65)
                                Text(name).bold()
                                    .font(.system(size: 32))
                                    .foregroundColor(Color(.label))
                                Spacer()
                            }
                            .padding()
                        })
                }
                if !otherUsername.isEmpty{
                    NavigationLink("",
                                   destination: ChatView(otherUsername: otherUsername),
                                   isActive: $showChat)
                }
            }
            .navigationTitle("Messages")
            .toolbar{
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading, content: {
                    Button("Sign Out"){
                        self.signOut()
                    }
                })
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing, content: {
                    NavigationLink(
                        destination: SearchView { name in
                            self.showSearch = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.otherUsername = name
                                self.showChat = true
                            })
                        },
                        isActive: $showSearch,
                        label: {
                            Image(systemName: "magnifyingglass")
                        })
                })
            }
            .fullScreenCover(isPresented: $model.showingSignIn, content: {
                SigninView()
            })
            .onAppear(){
                guard model.auth.currentUser != nil else {
                    return
                }
                model.getConversation()
            }
            
        }
    }
    func signOut(){
        model.signOut()
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
    }
}
