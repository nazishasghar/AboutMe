//
//  AboutMe1App.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 11/05/21.
//

import SwiftUI
import CoreData
@main
struct AboutMe1App: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onChange(of: scenePhase, perform: { value in
                    persistenceController.save()
                })
        }
    }

}
