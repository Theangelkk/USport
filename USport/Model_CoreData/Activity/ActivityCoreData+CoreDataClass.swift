//
//  ActivityCoreData+CoreDataClass.swift
//  USport
//
//  Created by Angelo Casolaro on 09/12/21.
//
//

import Foundation
import CoreData

@objc(ActivityCoreData)
public class ActivityCoreData: NSManagedObject
{
    static let userCalendar : Calendar = Calendar.current
    
    static let requestedComponents : Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
    
    func copy_Activity(activity : Activity)
    {
        self.title = activity.Title
        self.start_date = activity.Start_Time
        self.end_date = activity.End_Time
        self.type_of_sport = activity.Type_of_Sport
    }
    
    //--------------------------- CORE DATA FUNCTIONS --------------------------------------
    static func get_all_items() -> [ActivityCoreData]
    {
        let request : NSFetchRequest<ActivityCoreData> = ActivityCoreData.fetchRequest()
    
        do
        {
            return try CoreDataManager.persistentContainer!.viewContext.fetch(request)
        }
        catch
        {
            return []
        }
    }
    
    static func activities_of_today() -> [ActivityCoreData]
    {
        // Request to submit to CoreData
        let request : NSFetchRequest<ActivityCoreData> = ActivityCoreData.fetchRequest()
        
        var dataTimeComponets_StartTime = ActivityCoreData.userCalendar.dateComponents(self.requestedComponents, from: Date())
        var dataTimeComponets_EndTime = ActivityCoreData.userCalendar.dateComponents(self.requestedComponents, from: Date())
        
        dataTimeComponets_StartTime.hour! = 0
        dataTimeComponets_StartTime.minute! = 0
        dataTimeComponets_StartTime.second! = 1
        
        dataTimeComponets_EndTime.hour! = 23
        dataTimeComponets_EndTime.minute! = 59
        dataTimeComponets_EndTime.second! = 59
        
        let Start_Time : Date = self.userCalendar.date(from: dataTimeComponets_StartTime)!
        let End_Time : Date = self.userCalendar.date(from: dataTimeComponets_EndTime)!
        
        let pred = NSPredicate(format: "start_date >= %@ && end_date <= %@", Start_Time as CVarArg, End_Time as CVarArg)
        request.predicate = pred
        
        do
        {
            return try CoreDataManager.persistentContainer!.viewContext.fetch(request)
        }
        catch
        {
            return []
        }
    }
    
    static func save_user_on_CoreData(activity : Activity)
    {
        let new_activity_CoreData : ActivityCoreData = ActivityCoreData(context: CoreDataManager.persistentContainer!.viewContext)
          
        new_activity_CoreData.copy_Activity(activity : activity)

        do
        {
            try CoreDataManager.persistentContainer!.viewContext.save()
        }
        catch
        {
            print("Failed to save context ActivityCoreData")
        }
    }
    
    static func remove_user(obj : ActivityCoreData)
    {
        CoreDataManager.persistentContainer!.viewContext.delete(obj)
        
        do
        {
            try CoreDataManager.persistentContainer!.viewContext.save()
        }
        catch
        {
            print("Failed to save context ActivityCoreData")
        }
    }
}
