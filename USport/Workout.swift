//
//  Workout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation

public class Workout : Activity, NSSecureCoding
{
    public static var supportsSecureCoding: Bool = true
    
    @Published var Day : Int
    @Published var Intesity_Level : Int
    
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var IntensityOfLevel = ["Low", "Medium", "High"]
       
    enum Key : String
    {
        case Title = "Title"
        case Day = "Day"
        case Intensity_Level = "Intensity_Level"
        case Start_Time = "Start_Time"
        case End_Time = "End_Time"
    }
    
    override init()
    {
        self.Day = 0
        self.Intesity_Level = 0
        
        super.init()
        
    }
    
    init(newValue_Day : Int, newValue_Title: String, newValue_StartTime: Date, newValue_EndTime: Date, newValue_Intesity_Level : Int)
    {
        self.Day = 0
        self.Intesity_Level = 0
        
        super.init(newValue_Title: newValue_Title, newValue_StartTime: newValue_StartTime)
    }
    
    public required convenience init?(coder: NSCoder)
    {
        let mDay = coder.decodeInteger(forKey: Key.Day.rawValue)
        let mIntensity_Level = coder.decodeInteger(forKey: Key.Intensity_Level.rawValue)
        
        let mTitle = coder.decodeObject(forKey: Key.Title.rawValue) as? String
        let mStart_Time = coder.decodeObject(of: NSDate.self, forKey: Key.Start_Time.rawValue) as? Date
        let mEnd_Time = coder.decodeObject(of: NSDate.self, forKey: Key.End_Time.rawValue) as? Date
        
        self.init(newValue_Day: mDay, newValue_Title: mTitle!, newValue_StartTime: mStart_Time!, newValue_EndTime: mEnd_Time!, newValue_Intesity_Level: mIntensity_Level)
    }
    
    public func encode(with coder: NSCoder)
    {
        coder.encode(Day, forKey: Key.Day.rawValue)
        coder.encode(Title, forKey: Key.Title.rawValue)
        coder.encode(Start_Time, forKey: Key.Start_Time.rawValue)
        coder.encode(End_Time, forKey: Key.End_Time.rawValue)
        coder.encode(Intesity_Level, forKey: Key.Intensity_Level.rawValue)
    }
    
    func set_Day(idx : Int)
    {
        if(idx >= 0 && idx <= 7)
        {
            self.Day = idx
        }
    }
    
    func set_Start_time(idx: Int)
    {
        
    }
    func set_IntensityOfLevel(idx : Int)
    {
        if(idx >= 0 && idx <= 3)
        {
            self.Intesity_Level = idx
        }
    }
    
    func name_day() -> String
    {
        return self.days[self.Day]
    }
    
    func name_intensity() -> String
    {
        return self.IntensityOfLevel[self.Intesity_Level]
    }
}
