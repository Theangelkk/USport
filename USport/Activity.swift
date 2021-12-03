//
//  Activity.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation

class Activity
{
    internal var Title : String
    {
        get
        {
            return self.Title
        }
        
        set(newValue_Title)
        {
            self.Title = (newValue_Title)
        }
    }
    
    internal var Start_Time : Int
    {
        get
        {
            return self.Start_Time
        }
        
        set(newValue_StartTime)
        {
            self.Start_Time = newValue_StartTime
        }
    }
    
    internal var End_Time : Int
    {
        get
        {
            return self.End_Time
        }
        
        set(newValue_EndTime)
        {
            self.End_Time = newValue_EndTime
        }
    }
    
    init(newValue_Title : String, newValue_StartTime : Int, newValue_EndTime : Int)
    {
        self.Title = newValue_Title
        self.Start_Time = newValue_StartTime
        self.End_Time = newValue_EndTime
    }
}
