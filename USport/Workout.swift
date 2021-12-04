//
//  Workout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation

class Workout : Activity
{
    @Published var Day : String
    
    @Published var Intesity_Level : String
   
    override init()
    {
        self.Day = "Monday"
        self.Intesity_Level = "Low"
        
        super.init()
        
    }
    
    init(newValue_Day : String, newValue_Title: String, newValue_StartTime: Date, newValue_EndTime: Date, newValue_Intesity_Level : String)
    {
        self.Day = newValue_Day
        self.Intesity_Level = newValue_Intesity_Level
        
        super.init(newValue_Title: newValue_Title, newValue_StartTime: newValue_StartTime, newValue_EndTime: newValue_EndTime)
    }
    
}
