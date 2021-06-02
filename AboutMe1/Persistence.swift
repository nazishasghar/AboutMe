//
//  Persistence.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 11/05/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()


    let container: NSPersistentContainer
    static var preview: PersistenceController = {
            let controller = PersistenceController(inMemory: true)
            return controller
        }()
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "AboutMe1")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
        func save(completion: @escaping (Error?) -> () = {_ in}) {
            let context = container.viewContext

            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Show some error here
                    print(error.localizedDescription)
                }
            }
    }
    func delete(_ object: NSManagedObject,completion: @escaping (Error?) -> () = {_ in}){
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
    func deleteData() {
        let context = container.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonalInfo")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            try context.execute(request)
                try context.save()
            
            } catch {
                print ("There was an error")
            }
        context.reset()
    }
    
}
