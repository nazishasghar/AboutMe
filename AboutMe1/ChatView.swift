//
//  ChatView.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 03/06/21.
//

import SwiftUI

struct ChatView: View {
    @State var SearchMessage = ""
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                SearchBar(text: $SearchMessage, placeholder: "Search Messages")
                List(0..<10){ msg in
                    HStack{
                        Image(systemName: "message.circle.fill").frame(alignment:.leading).scaledToFit()
                        VStack(alignment:.leading , spacing: 5){
                            Text("Name").fontWeight(.semibold).lineLimit(2)
                            Text("Address").font(.subheadline).foregroundColor(.secondary)
                        }.padding(.horizontal)
                    }
                }
            }.navigationBarItems(trailing: NewChat)
            .navigationBarTitle("Messages")
        }
    }
    var NewChat : some View{
        Button(action: {
            
        }, label: {
            Image(systemName: "square.and.pencil")
        })
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
