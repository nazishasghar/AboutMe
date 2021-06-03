//
//  ContentsView.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 11/05/21.
//

import SwiftUI
import LocalAuthentication
import CoreData
var isUnlocked = true
struct ContentsView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: PersonalInfo.entity(), sortDescriptors: []) var personal : FetchedResults<PersonalInfo>
    var body: some View {
        if isUnlocked {
            TabView{
                NavigationView{
                    ContactList()
                }
                .tabItem {Image(systemName: "person.crop.circle.fill") }
                VStack{
                    MapViewTesting()
                }
                .tabItem { Image(systemName: "map.fill")}
                NavigationView{
                    PersonalView()
                }
                .tabItem { Image(systemName: "person.fill") }
                    ChatView()
                .tabItem({Image(systemName: "message.circle.fill")})
            }
        }
        else{
            authenticateView()
        }
    }
    struct ContactList : View {
        @State var isEdited : Bool = false
        @State var searchText : String = ""
        @Environment(\.managedObjectContext) var viewContext
        @State var isPresented = false
        @State private var tappedLink: String? = nil
        @FetchRequest(entity: ContactsInfo.entity(), sortDescriptors: [],predicate:NSPredicate(format: "name != nil")) var Contacts: FetchedResults<ContactsInfo>
        var body: some View {
            VStack{
                SearchBar(text: $searchText,placeholder: "Search Contacts")
                    .padding(.top)
                List{
                    ForEach(Contacts.filter({ searchText.isEmpty ? true : $0.name!.lowercased().contains(self.searchText.lowercased())})){ contacts in
                        ZStack{
                            Button("") {}
                            VStack(alignment:.leading){
                                Text("\(contacts.name ?? "")")
                                Text("\(contacts.address ?? "")").font(.caption2)
                                Text("\(contacts.email ?? "" )").font(.caption2)
                                NavigationLink(
                                    destination:DetailsContactView(Contact: contacts)){
                                }
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        deleteItem(at: indexSet)
                    })
                }
            }
            .navigationBarItems(leading: EditButton())
            .navigationTitle("Add Contact")
            .navigationBarItems(trailing:Button(action: {
                                                    isPresented.toggle()}, label: {
                                                        Image(systemName: "plus")
                                                    })
                                    .sheet(isPresented: $isPresented, content: {
                                        AddContactView().environment(\.managedObjectContext, viewContext)
                                    })
            )
        }
        
        func deleteItem(at offsets:IndexSet) {
            for index in offsets{
                let item = Contacts[index]
                PersistenceController.shared.delete(item)
            }
        }
    }
    struct authenticateView : View {
        
        var body: some View
        {
            VStack{
                Text("Tap Any Where To Authenticate")
                    .font(.italic(.title)())
            }.frame(maxWidth:.infinity ,maxHeight: .infinity)
            .contentShape(Rectangle())
            .foregroundColor(.red)
            .onTapGesture(perform: {
                authenticate()
            })
        }
        func authenticate() {
            let context = LAContext()
            let reason = "Authenticate"
            var error =  NSError?.none
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason){ success,authenticationError in
                    if success {
                        isUnlocked = true
                    }
                    else{
                        
                    }
                }
            }
            else{
                
            }
        }
    }
}


//struct ContentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentsView()
//    }
//}

