//
//  Activity.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation

class Activity : ObservableObject
{
    @Published var Title : String
    
    @Published var Start_Time : Date
    
    @Published var End_Time : Date
    
    
    init()
    {
        self.Title = "Workout"
        self.Start_Time = Date()
        self.End_Time = Date()
    }
    
    init(newValue_Title : String, newValue_StartTime : Date, newValue_EndTime : Date)
    {
        self.Title = newValue_Title
        self.Start_Time = newValue_StartTime
        self.End_Time = newValue_EndTime
    }
}
