//
//  UserCoreData+CoreDataClass.swift
//  USport
//
//  Created by Angelo Casolaro on 08/12/21.
//
//

import Foundation
import CoreData

@objc(UserCoreData)
public class UserCoreData: NSManagedObject
{
    static var actual_userCoreData : UserCoreData? = nil
    
    func copy_User(usr : User)
    {
        self.nickname = usr.nickname
        self.age = Int64(usr.Age)
        self.gender = usr.gender
        self.height = Int64(usr.height)
        self.weight = usr.weight
        self.type_of_sport = usr.Type_of_Sport
        self.type_of_activity = usr.Type_Activity
        
        self.workouts = Workouts(workouts: usr.workouts)
    }
    
    //--------------------------- CORE DATA FUNCTIONS --------------------------------------
    static func get_user() -> UserCoreData?
    {
        let request : NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
    
        do
        {
            let ans : [UserCoreData] = try CoreDataManager.persistentContainer!.viewContext.fetch(request)
                    
            if ans.count > 0
            {
                self.actual_userCoreData = ans[0]
                
                return self.actual_userCoreData
            }
            else
            {
                return nil
            }
        }
        catch
        {
            return nil
        }
    }
    
    static func save_user_on_CoreData(user : User, delete_old : Bool)
    {
        UserCoreData.actual_userCoreData = UserCoreData.get_user()
        
        if UserCoreData.actual_userCoreData == nil
        {
            UserCoreData.actual_userCoreData = UserCoreData(context: CoreDataManager.persistentContainer!.viewContext)
        }

        UserCoreData.actual_userCoreData!.copy_User(usr: user)
        
        print(UserCoreData.actual_userCoreData!)
        
        print(UserCoreData.actual_userCoreData!.workouts!.workouts[0].Day)
        
        do
        {
            try CoreDataManager.persistentContainer!.viewContext.save()
        }
        catch
        {
            print("Failed to save context UserCoreData")
        }
    }
    
    static func remove_user(obj : UserCoreData)
    {
        CoreDataManager.persistentContainer!.viewContext.delete(obj)
        
        do
        {
            try CoreDataManager.persistentContainer!.viewContext.save()
        }
        catch
        {
            print("Failed to save context UserCoreData")
        }
    }
}
