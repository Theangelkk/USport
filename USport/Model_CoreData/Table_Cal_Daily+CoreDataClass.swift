//
//  Table_Cal_Daily+CoreDataClass.swift
//  USport
//
//  Created by Angelo Casolaro on 07/12/21.
//
//

import Foundation
import CoreData

@objc(Table_Cal_Daily)

public class Table_Cal_Daily: NSManagedObject
{
    static let userCalendar : Calendar = Calendar.current
    
    static let requestedComponents : Set<Calendar.Component> = [ .year, .month, .day, .hour, .minute, .second ]
    
    static let formatter = DateFormatter()
    
    static func get_all_items() -> [Table_Cal_Daily]
    {
        let request : NSFetchRequest<Table_Cal_Daily> = Table_Cal_Daily.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do
        {
            return try CoreDataManager.persistentContainer!.viewContext.fetch(request)
        }
        catch
        {
            return []
        }
    }
    
    static func average_cal_days() -> Float
    {
        let today : Date = Date()
        
        Table_Cal_Daily.formatter.locale = .current
        Table_Cal_Daily.formatter.dateFormat = "EEEE"
        
        let name_today = Table_Cal_Daily.formatter.string(from: today)
        
        // Request to submit to CoreData
        let request : NSFetchRequest<Table_Cal_Daily> = Table_Cal_Daily.fetchRequest()
        
        let pred = NSPredicate(format: "name_day CONTAINS %@", name_today)
        request.predicate = pred
        
        var items : [Table_Cal_Daily] = [Table_Cal_Daily]()
        
        do
        {
            items = try CoreDataManager.persistentContainer!.viewContext.fetch(request)
        }
        catch
        {
            items = []
        }
        
        return self.avg_cal(items: items)
    }
    
    static func average_cal_week() -> Float
    {
        // Request to submit to CoreData
        let request : NSFetchRequest<Table_Cal_Daily> = Table_Cal_Daily.fetchRequest()
        
        request.fetchLimit = 7
        
        var items : [Table_Cal_Daily] = [Table_Cal_Daily]()
        
        do
        {
            items = try CoreDataManager.persistentContainer!.viewContext.fetch(request)
        }
        catch
        {
            items = []
        }
        
        return self.avg_cal(items: items)
    }
    
    static func average_cal_mounth() -> Float
    {
        // Request to submit to CoreData
        let request : NSFetchRequest<Table_Cal_Daily> = Table_Cal_Daily.fetchRequest()
        
        request.fetchLimit = 30
        
        var items : [Table_Cal_Daily] = [Table_Cal_Daily]()
        
        do
        {
            items = try CoreDataManager.persistentContainer!.viewContext.fetch(request)
        }
        catch
        {
            items = []
        }
        
        return self.avg_cal(items: items)
    }
    
    static func range_cal_days(start_date : Date, end_date : Date) -> (list_objs : [Table_Cal_Daily], Total_cal_daily : Float, Total_cal_sport : Float)
    {
        var items : [Table_Cal_Daily] = [Table_Cal_Daily]()
        
        // Request to submit to CoreData
        let request : NSFetchRequest<Table_Cal_Daily> = Table_Cal_Daily.fetchRequest()
        
        let pred = NSPredicate(format: "date >= %@ && date <= %@", start_date as CVarArg, end_date as CVarArg)
        request.predicate = pred
        
        do
        {
            items = try CoreDataManager.persistentContainer!.viewContext.fetch(request)
        }
        catch
        {
            items = []
        }
        
        var Total_cal_daily : Float = 0.0
        var Total_cal_sport : Float = 0.0
        
        for i in 0..<items.count
        {
            let item : Table_Cal_Daily = items[i]
            
            Total_cal_daily += item.cal_daily
            Total_cal_sport += item.cal_sport
        }
        
        return (items, Total_cal_daily, Total_cal_sport)
    }
    
    static func get_first_date() -> Date
    {
        var items : [Table_Cal_Daily] = [Table_Cal_Daily]()
        
        // Request to submit to CoreData
        let request : NSFetchRequest<Table_Cal_Daily> = Table_Cal_Daily.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
                
        do
        {
            items = try CoreDataManager.persistentContainer!.viewContext.fetch(request)
        }
        catch
        {
            items = []
        }
        
        if(items.count > 0)
        {
            return items[0].date!
        }
        else
        {
            return Date()
        }
    }
    
    static func avg_cal(items : [Table_Cal_Daily]) -> Float
    {
        var Total_cal_daily : Float = 0.0
        var Total_cal_sport : Float = 0.0
        
        for i in 0..<items.count
        {
            let item : Table_Cal_Daily = items[i]
            
            Total_cal_daily += item.cal_daily
            Total_cal_sport += item.cal_sport
        }
        
        return Float(Float(Total_cal_daily + Total_cal_sport) / Float(items.count))
    }
    
    static func save_item_on_CoreData()
    {
        do
        {
            try CoreDataManager.persistentContainer!.viewContext.save()
        }
        catch
        {
            print("Failed to save context Table_Cal_Daily")
        }
    }

    static func test(n_days : Int)
    {
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        
        var cal_daily: Float = Float.random(in: 1200.0 ..< 2500.0)
        var cal_sport: Float = Float.random(in: 400.0 ..< 1200.0)
        
        var dates = [Date]()
        
        dates.append(Date())
        
        Table_Cal_Daily.formatter.locale = .current
        Table_Cal_Daily.formatter.dateFormat = "EEEE"
        
        var name_today = self.formatter.string(from: Date())
        
        var obj : Table_Cal_Daily = Table_Cal_Daily(context: CoreDataManager.persistentContainer!.viewContext)
        
        obj.date = Date()
        obj.name_day = name_today
        obj.cal_daily = cal_daily
        obj.cal_sport = cal_sport
        
        Table_Cal_Daily.save_item_on_CoreData()
        
        var count : Int = 0
        
        for _ in 1 ... n_days
        {
            date = cal.date(byAdding: .day, value: -1, to: date)!
            
            dates.append(date)
            
            name_today = self.formatter.string(from: date)
            
            cal_daily = Float.random(in: 1200.0 ..< 2500.0)
            
            if(count == 1)
            {
                cal_sport = 0.0
                
                count = 0
            }
            else
            {
                cal_sport = Float.random(in: 400.0 ..< 1200.0)
                
                count += 1
            }
                        
            obj = Table_Cal_Daily(context: CoreDataManager.persistentContainer!.viewContext)
            
            obj.date = date
            obj.name_day = name_today
            obj.cal_daily = cal_daily
            obj.cal_sport = cal_sport
            
            Table_Cal_Daily.save_item_on_CoreData()
        }
    }
    
    static func remove_item(obj : Table_Cal_Daily)
    {
        CoreDataManager.persistentContainer!.viewContext.delete(obj)
    }
    
    static func remove_all()
    {
        var items : [Table_Cal_Daily] = [Table_Cal_Daily]()
        
        let request : NSFetchRequest<Table_Cal_Daily> = Table_Cal_Daily.fetchRequest()
        
        do
        {
            items = try CoreDataManager.persistentContainer!.viewContext.fetch(request)
        }
        catch
        {
            items = []
        }
        
        for i in 0..<items.count
        {
            Table_Cal_Daily.remove_item(obj :items[i])
        }
    }
}

