//
//  SignUpView.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 03/06/21.
//

import SwiftUI

struct SignUpView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var email : String = ""
    @EnvironmentObject var model: AppStateModel
    var body: some View {
            VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120 ,height: 120)
                VStack{
                    TextField("Email Address", text: $email)
                        .modifier(CustomField())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    TextField("Username", text: $username)
                        .modifier(CustomField())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $password)
                        .modifier(CustomField())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    Button(action: {
                        self.signUp()
                    }, label: {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .frame(width:220,height: 50)
                            .background(Color.green)
                            .cornerRadius(6)
                        
                    })
                }
                .padding()
                
                Spacer()
                
            }
            .navigationBarTitle("Create Account", displayMode: .inline)
    }
    func signUp(){
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,!password.trimmingCharacters(in: .whitespaces).isEmpty,password.count >= 6,!email.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        model.signUp(email: email, username: username, password: password)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
