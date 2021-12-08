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
        
        print(self)
        print("pippo")
    }
    
    //--------------------------- CORE DATA FUNCTIONS --------------------------------------
    static func get_user() -> UserCoreData?
    {
        let request : NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
    
        do
        {
            var ans : [UserCoreData] = try CoreDataManager.persistentContainer!.viewContext.fetch(request)
            
            print(ans)
            print(ans.count)
            
            if ans.count > 0
            {
                return ans[0]
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
        if delete_old == true
        {
            let usr : UserCoreData? = UserCoreData.get_user()
        
            if usr != nil
            {
                UserCoreData.remove_user(obj: usr!)
            }
        }
        
        var new_userCoreData : UserCoreData = UserCoreData(context: CoreDataManager.persistentContainer!.viewContext)
        
        new_userCoreData.copy_User(usr: user)
        
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
    }
}
