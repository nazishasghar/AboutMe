//
//  SigninView.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 03/06/21.
//

import SwiftUI

struct SigninView: View {
    @State var username: String = ""
    @State var password: String = ""
    @EnvironmentObject var model: AppStateModel
    var body: some View {
        NavigationView{
            VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120 ,height: 120)
                Text("Conversation")
                    .bold()
                    .font(.system(size: 34))
                VStack{
                    TextField("Username", text: $username)
                        .modifier(CustomField())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $password)
                        .modifier(CustomField())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    Button(action: {
                        self.signIn()
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .frame(width:220,height: 50)
                            .background(Color.blue)
                            .cornerRadius(6)
                        
                    })
                }
                .padding()
                
                Spacer()
                HStack{
                    Text("New to Conservation?")
                    NavigationLink("Create Account", destination: SignUpView())
                }
            }

        }
    }
    func signIn(){
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,!password.trimmingCharacters(in: .whitespaces).isEmpty,password.count >= 6 else {
            return
        }
        
        model.signIn(username: username, password: password)
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
