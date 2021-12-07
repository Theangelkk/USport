//
//  CoreDataManager.swift
//  USport
//
//  Created by Angelo Casolaro on 07/12/21.
//

import Foundation
import CoreData

/*
    CoreDataManager
 */

class CoreDataManager : ObservableObject
{
    static var persistentContainer : NSPersistentContainer? = nil
    
    static func start()
    {
        // Initialitation of persistentContainer
        self.persistentContainer = NSPersistentContainer(name: "USport_CoreData")
        self.persistentContainer!.loadPersistentStores{ (description,error) in
                                if let error = error
                                {
                                    fatalError("Core Data Store error")
                                }
        }
    }
        
    func save_context()
    {
        do
        {
            try CoreDataManager.persistentContainer!.viewContext.save()
        }
        catch
        {
            print("Failed to save context Core Data")
        }
    }
}
