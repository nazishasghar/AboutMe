//
//  SendButton.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 03/06/21.
//

import SwiftUI

struct SendButton: View {
    @Binding var text : String
    @EnvironmentObject var model : AppStateModel
    var body: some View {
        Button(action: {
            self.sendMessage()
        }, label: {
            Image(systemName: "paperplane")
                .font(.system(size: 33))
                .aspectRatio(contentMode: .fit)
                .frame(width:55,height: 55)
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(Circle())
        })
    }
    func sendMessage() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        model.sendMessage(text: text)
        text = ""
    }
}

//struct SendButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SendButton(text: "hellowolrd")
//    }
//}
