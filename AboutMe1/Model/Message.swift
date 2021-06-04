//
//  Message.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 03/06/21.
//

import Foundation

enum MessageType : String{
    case sent
    case received
}

struct Message : Hashable {
    let text : String
    let type : MessageType
    let created : Date
}
