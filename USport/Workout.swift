//
//  Workout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation

typealias Codable_Workout = Decodable & Encodable

class Workout : Activity
{
    @Published var Day : Int
    @Published var Intesity_Level : Int
    
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var IntensityOfLevel = ["Low", "Medium", "High"]
    
    let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
   
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
    
    func encode_json()
    {
        let wrk_enc : WorkoutEnc = WorkoutEnc(Day: self.name_day(), Intesity_Level: self.name_intensity())
        let fileURL = dir?.appendingPathComponent("Workout").appendingPathExtension("json")
        let enc : IO_Dictionary = IO_Dictionary<WorkoutEnc>(newValue_path_dictionary: fileURL)
        
        enc.write(obj: wrk_enc)
    }
}

struct WorkoutEnc: Codable_Workout
{
    var Day : String = ""
    var start: String = ""
    var end: String = ""
    var Intesity_Level : String = ""
    
    
}

