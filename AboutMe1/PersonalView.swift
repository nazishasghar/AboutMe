//
//  PersonalView.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 13/05/21.
//

import SwiftUI
struct PersonalView: View  {
    @ObservedObject var info = PersonalInfo()
    var bloodGroupArray = ["A+","A-","B+","B-","O+","O-","AB+","AB-"]
    let dateformatter =  DateFormatter()
    @State var isPresented: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: PersonalInfo.entity(), sortDescriptors: []) var personalFetchin : FetchedResults<PersonalInfo>
    @State var isDonor : Bool = false
    static let taskDateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    init() {
        info = PersonalInfo(context: viewContext)
       
    }
    var body: some View {
        if personalFetchin.isEmpty{
            VStack{
            
            }
        .navigationTitle("Personal Info")
        .navigationBarItems(trailing: Button(action: {
                print(personalFetchin.count)
            isPresented.toggle()}, label: {
            Image(systemName: "slider.horizontal.3")
            })
            .sheet(isPresented: $isPresented, content: {
                
                    PersonalAdd().environment(\.managedObjectContext, viewContext)
                
            })
        )
    
    }
        else {
            Form{
                Section(header:Text("Name").padding(.horizontal)){
                      Text(personalFetchin.first?.name ?? "")
                  }
                  Section(header:Text("Address").padding(.horizontal)){
                      Text(personalFetchin.first?.address ?? "")
                  }
                  Section(header:Text("Email").padding(.horizontal)){
                      Text(personalFetchin.first?.email ?? "")
                  }
                  Section(header:Text("Date Of Birth").padding(.horizontal)){
                      Text("\((personalFetchin.first?.dateofbirth) ?? Date(), formatter: Self.taskDateFormat)")
                  }
                  Section(header:Text("Mobile Number").padding(.horizontal)){
                      Text(personalFetchin.first?.phonenumber ?? "")
                  }
                  Section(header:Text("Blood Group").padding(.horizontal)){
                      Text(personalFetchin.first?.bloodgroup ?? "")
                  }
                  Section(header:Text("Organ Donor").padding(.horizontal)){
                    if ((personalFetchin.first?.organdonor == true)){
                        Text("A Organ Donor")
                    }
                    else{
                        Text("Not A Organ Donor")
                    }
                  }
              }
            .navigationTitle("Personal Info")
            .navigationBarItems(leading:
                Button("Reset"){
                    PersistenceController.shared.deleteData()
                    info.objectWillChange.send()
                }
                ,trailing: Button(action: {
                    print(personalFetchin.count)
                isPresented.toggle()}, label: {
                Image(systemName: "slider.horizontal.3")
                })
                .sheet(isPresented: $isPresented, content: {
                    PersonalAdd().environment(\.managedObjectContext, viewContext)
                })
            )
          
        }
        
    }
  
    func deleteItem(at offsets:IndexSet) {
        for index in offsets{
            let item = personalFetchin[index]
            PersistenceController.shared.delete(item)
        }
    }
}
extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
//struct PersonalView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonalView()
//    }
//}
