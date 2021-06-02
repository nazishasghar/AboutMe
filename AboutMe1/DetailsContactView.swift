//
//  DetailsContactView.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 13/05/21.
//

import SwiftUI
import CoreData
struct DetailsContactView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presenation
    @State var Contact : ContactsInfo
    var body: some View {
        Form{
            Section{
                TextField("Enter Name", text: Binding($Contact.name)!)
            }
            Section{
                TextField("Enter Address", text: Binding($Contact.address)!)
            }
            Section{
                TextField("Enter Email", text: Binding($Contact.email)!).keyboardType(.emailAddress)
            }
            Section{
                DatePicker("Enter BirthDate", selection:Binding($Contact.dateofbirth)!)
            }
            Section{
                TextField("Enter PhoneNumber", text:Binding($Contact.phonenumber)!).keyboardType(.numberPad)
            }
        }
        .navigationBarTitle("Details Of Contact")
        .ignoresSafeArea()
        .navigationBarItems(trailing: Done)
    }
    var Done :some View{
        Button("Done"){
            PersistenceController.shared.save()
            self.presenation.wrappedValue.dismiss()
        }
    }
}

//struct DetailsContactView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsContactView()
//    }
//}
