//
//  Workout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation

class Workout : Activity
{
    internal var Day : Date
    {
        get
        {
            return self.Day
        }
        
        set(newValue_Day)
        {
            self.Day = newValue_Day
        }
    }
    
    internal var Intesity_Level : String
    {
        get
        {
            return self.Intesity_Level
        }
        
        set(newValue_Intesity_Level)
        {
            if (newValue_Intesity_Level == "Low" || newValue_Intesity_Level == "Medium" || newValue_Intesity_Level == "High")
            {
                self.Intesity_Level = newValue_Intesity_Level
            }
            else
            {
                self.Intesity_Level = "Low"
            }
        }
    }
    
    init(newValue_Day : Date, newValue_Title: String, newValue_StartTime: Int, newValue_EndTime: Int, newValue_Intesity_Level : String )
    {
        super.init(newValue_Title: newValue_Title, newValue_StartTime: newValue_StartTime, newValue_EndTime: newValue_EndTime)
    }
    
}
