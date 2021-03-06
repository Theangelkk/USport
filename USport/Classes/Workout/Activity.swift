//
//  Activity.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation

public class Activity : NSObject, ObservableObject
{
    @Published var Title : String
    
    @Published var Start_Time : Date
    
    @Published var End_Time : Date
    
    @Published var Type_of_Sport : String
    
    let userCalendar : Calendar = Calendar.current
    
    let requestedComponents : Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second ]
    
    override init()
    {
        self.Title = "Workout"
        self.Start_Time = Date()
        self.End_Time = Date()
        
        self.Type_of_Sport = "Default"
        
        super.init()
        
        var dataTimeComponets_StartTime = self.userCalendar.dateComponents(self.requestedComponents, from: self.Start_Time)
        dataTimeComponets_StartTime.minute! += 30
        
        self.End_Time = self.userCalendar.date(from: dataTimeComponets_StartTime)!
    }
    
    init(newValue_Title : String, newValue_StartTime : Date, type_of_sport : String)
    {
        self.Title = "Workout"
        self.Start_Time = Date()
        self.End_Time = Date()
        
        self.Title = newValue_Title
        self.Start_Time = newValue_StartTime
        
        self.Type_of_Sport = type_of_sport
        
        super.init()
        
        var dataTimeComponets_StartTime = self.userCalendar.dateComponents(self.requestedComponents, from: self.Start_Time)
        dataTimeComponets_StartTime.minute! += 30
        
        self.End_Time = self.userCalendar.date(from: dataTimeComponets_StartTime)!
    }
    
    func set_Title(title : String) -> Bool
    {
        if(title != "")
        {
            self.Title = title
            return true
        }
        
        return false
    }
    
    func set_EndTime(end : Date) -> Bool
    {
        let dataTimeComponets_StartTime = self.userCalendar.dateComponents(self.requestedComponents, from: self.Start_Time)
        let dataTimeComponets_EndTime = self.userCalendar.dateComponents(self.requestedComponents, from: end)
        
        if (dataTimeComponets_StartTime.hour! == dataTimeComponets_EndTime.hour!)
        {
            let diff : Int = dataTimeComponets_EndTime.minute! - dataTimeComponets_StartTime.minute!
            
            if(diff >= 30)
            {
                self.End_Time = end
                return true
            }
            
        }
        
        if (dataTimeComponets_StartTime.hour! < dataTimeComponets_EndTime.hour!)
        {
            self.End_Time = end
            return true
        }
        
        return false
    }
}
