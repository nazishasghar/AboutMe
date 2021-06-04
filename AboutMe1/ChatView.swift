//
//  ChatView.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 03/06/21.
//

import SwiftUI
struct CustomField : ViewModifier {
    func body(content: Content) -> some View {
       return content
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(7)
    }
}
struct ChatView: View {
    @EnvironmentObject var model :AppStateModel
    @State var message : String = ""
    let otherUsername : String
    init(otherUsername: String) {
        self.otherUsername = otherUsername
    }
    var body: some View {
        VStack{
        ScrollView(.vertical){
            ForEach(model.messages , id: \.self){ message in
                ChatRow(text: message.text, type: message.type).padding(3)
            }
        }
            HStack{
                TextField("Message..." , text: $message)
                    .modifier(CustomField())
                SendButton(text: $message)
            }
        }
        .navigationBarTitle(otherUsername, displayMode: .inline)
        .onAppear(){
            model.otherUsername = otherUsername
            model.observeChat()
        }
    }
  }
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(otherUsername: "Samantha")
    }
}
