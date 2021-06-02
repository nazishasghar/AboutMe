//
//  AddPersonalInfo.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 12/05/21.
//

import SwiftUI

struct PersonalAdd : View{
    @Environment(\.managedObjectContext) var viewContext
    var body:some View{
        NavigationView{
            AddPersonal()
        }
    }
}
struct AddPersonal : View {
    @State var mPersonalInfo : PersonalInfo?
    @FetchRequest(entity: PersonalInfo.entity(), sortDescriptors: []) var personalFetchin : FetchedResults<PersonalInfo>
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentionMode
    var bloodGroupArray = ["A+","A-","B+","B-","O+","O-","AB+","AB-"]
    @State var isPresented: Bool = false
    @State var ToggleOn : Bool = false
    @State var name : String?
    @State var address : String?
    @State var phonenumber : String?
    @State var email : String?
    @State var bloodGroup :String = "A+"
    @State var dateofbirth = Date()
   
    var body: some View{
        
                Form{
                    Section{
                        TextField("Enter Name", text: $name.onNone(""))
                    }
                    Section{
                        TextField("Enter Email", text: $email.onNone(""))
                    }
                    Section{
                        TextField("Enter address", text: $address.onNone(""))
                    }
                    Section{
                        TextField("Enter Phone Number", text: $phonenumber.onNone(""))
                    }
                    Section{
                        DatePicker("Enter Birthdate", selection: $dateofbirth, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                    Section{
                        Picker("Select BloodGroup", selection: $bloodGroup, content: {
                            ForEach(bloodGroupArray,id:\.self){ bloodgroup in
                                Text(bloodgroup)
                            }
                        })
                    }
                    Section{
                        Toggle("Organ Donor", isOn: $ToggleOn)
                    }
                }
                .navigationBarTitle("Personal Info")
                .navigationBarItems(leading: Button("Cancel"){
                    presentionMode.wrappedValue.dismiss()
                }, trailing: Button("Done"){
                    if personalFetchin.isEmpty && self.name?.isEmpty != nil{
                        mPersonalInfo = PersonalInfo(context: viewContext)
                        mPersonalInfo?.name = self.name
                        mPersonalInfo?.email = self.email
                        mPersonalInfo?.address = self.address
                        mPersonalInfo?.bloodgroup = self.bloodGroup
                        mPersonalInfo?.dateofbirth = self.dateofbirth
                        mPersonalInfo?.phonenumber = self.phonenumber
                        mPersonalInfo?.organdonor = self.ToggleOn
                        PersistenceController.shared.save()
                        try? viewContext.save()
                        presentionMode.wrappedValue.dismiss()
                        
                    }
                    else{
                        if ((self.name?.isEmpty) != nil){
                        personalFetchin.first?.name = self.name
                        personalFetchin.first?.email = self.email
                        personalFetchin.first?.address = self.address
                        personalFetchin.first?.bloodgroup = self.bloodGroup
                        personalFetchin.first?.dateofbirth = self.dateofbirth
                        personalFetchin.first?.phonenumber = self.phonenumber
                        personalFetchin.first?.organdonor = self.ToggleOn
                            try? viewContext.save()
                            presentionMode.wrappedValue.dismiss()
                        }
                        else{
                            presentionMode.wrappedValue.dismiss()
                        }
                    }
                    
                })
                
               
}
    
}

//struct AddPersonalInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPersonalInfo(true)
//    }
//}
