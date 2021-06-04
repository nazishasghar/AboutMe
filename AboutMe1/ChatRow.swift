//
//  ChatRow.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 03/06/21.
//

import SwiftUI

struct ChatRow: View {
    let type : MessageType
    let text : String
    var isSender : Bool{
        return type == .sent
    }
    init(text: String,type: MessageType) {
        self.type = type
        self.text = text
    }
    var body: some View {
        HStack{
            if isSender { Spacer() }
            if !isSender {
                VStack{
                    Spacer()
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(.pink)
                }
            }
            HStack{
                Text(text).padding().foregroundColor(isSender ? Color.white : Color(.label))
            }
            .background(isSender ? Color.blue : Color(.systemGray4))
            .padding(isSender ? .leading : .trailing, isSender ? UIScreen.main.bounds.width / 3 : UIScreen.main.bounds.width / 5)
            .cornerRadius(10)
            
            if !isSender {Spacer()}
        }
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ChatRow(text: "Test", type: .sent).preferredColorScheme(.dark)
            ChatRow(text: "Test", type: .received).preferredColorScheme(.dark)
        }
    }
}
