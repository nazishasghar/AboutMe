//
//  SearchView.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 03/06/21.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentionMode : Binding<PresentationMode>
    @EnvironmentObject var model: AppStateModel
    @State var text :String = ""
    @State var username: [String] = []
    let completion : ((String) -> Void)
    init(completion: @escaping (String)-> Void) {
        self.completion = completion
    }
    var body: some View {
        VStack{
            TextField("Username...", text: $text)
                .modifier(CustomField())
                .disableAutocorrection(true)
                .autocapitalization(.none)
            Button("Search"){
                guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                    return
                }
                model.searchUser(queryText: text){ username in
                    self.username = username
                }
            }
            List{
                ForEach(username, id: \.self) { name in
                    HStack{
                        Circle()
                            .frame(width:55 , height: 55)
                            .foregroundColor(.green)
                        Text(name)
                            .font(.system(size: 24))
                        Spacer()
                    }
                    .onTapGesture {
                        presentionMode.wrappedValue.dismiss()
                        completion(name)
                    }
                }
            }
            Spacer()
        }
        .navigationTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(){_ in }
    }
}
