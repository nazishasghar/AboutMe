//
//  AboutMe1App.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 11/05/21.
//

import SwiftUI
import CoreData
import Firebase
@main
struct AboutMe1App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate: AppDelegate
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentsView()
                .environmentObject(AppStateModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onChange(of: scenePhase, perform: { value in
                    persistenceController.save()
                })
        }
    }

}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Did launch")
        return true
    }
}
