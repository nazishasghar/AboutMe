//
//  AddContact.swift
//  AboutMe
//
//  Created by Nazish Asghar on 11/05/21.
//

import SwiftUI
import CoreData
struct AddContactView: View {
    var body: some View {
        NavigationView{
            AddContact()
        }
}
struct AddContact : View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentionMode
    @State private var name : String?
    @State private var dateOfbirth = Date()
    @State private var address :String?
    @State private var phoneNumber : String?
    @State private var email : String?
    var body: some View{
        
                Form{
                    Section{
                        TextField("Enter Name", text: $name.onNone(""))
                    }
                    Section{
                        TextField("Enter Address", text: $address.onNone(""))
                    }
                    Section{
                        TextField("Enter Email", text: $email.onNone("")).keyboardType(.emailAddress)
                    }
                    Section{
                        DatePicker("Enter BirthDate", selection: $dateOfbirth,displayedComponents: .date).datePickerStyle(GraphicalDatePickerStyle())
                    }
                    Section{
                        TextField("Enter PhoneNumber", text: $phoneNumber.onNone("")).keyboardType(.numberPad)
                            
                    }
                }
                .adaptsToKeyboard()
                .navigationBarTitle("Details Of Contact")
                .navigationBarItems(leading:Cancel ,trailing: Done)
                .ignoresSafeArea()
        }
    var Cancel : some View{
        Button("Cancel"){
            presentionMode.wrappedValue.dismiss()
        }
    }
    var Done : some View{
        Button("Done"){
            let newContact =  ContactsInfo(context: viewContext)
            newContact.name = self.name
            newContact.address = self.address
            newContact.email = self.email
            newContact.dateofbirth = self.dateOfbirth
            newContact.phonenumber = self.phoneNumber
            if (newContact.name != nil) && (newContact.address != nil) && (newContact.email != nil) && (newContact.dateofbirth != nil) && (newContact.phonenumber != nil){
                try? self.viewContext.save()
                presentionMode.wrappedValue.dismiss()
            }
            else{
                presentionMode.wrappedValue.dismiss()
            }
        }
    }
    }

struct AddContact_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}    
}
extension Binding where Value == String? {
    func onNone(_ fallback: String) -> Binding<String> {
        return Binding<String>(get: {
            return self.wrappedValue ?? fallback
        }) { value in
            self.wrappedValue = value
        }
    }
}
