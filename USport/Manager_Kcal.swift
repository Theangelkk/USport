//
//  Manager_Kcal.swift
//  USport
//
//  Created by Angelo Casolaro on 06/12/21.
//

import Foundation

class Manager_Kcal
{
    var user : User
    
    let coeff_RMR : Float = 9.99
    let coeff_RMR_Male : Float = 5.0
    let coeff_RMR_Famale : Float = 161.0
    
    // Da prendere da HealthKit
    var steps_counter : Int = 1000
    
    let coeff_step_lenght_male : Float = 0.413
    let coeff_step_lenght_famale : Float = 0.415
    
    var coeff_Activity : [String : Float] = [
                                                "Sedentary lifestyle" : 1.2,
                                                 "Slightly active" : 1.375,
                                                 "Moderately active" : 1.55,
                                                 "Active lifestyle" : 1.725,
                                                 "Very active lifestyle" : 1.9
                                            ]
    
    var RMR : Float = 0.0
    
    let userCalendar : Calendar = Calendar.current
    
    let requestedComponents : Set<Calendar.Component> = [ .year, .month, .day, .hour, .minute, .second ]
    
    let formatter = DateFormatter()
    
    init(user : User)
    {
        self.user = user
        
        self.formatter.locale = .current
        self.formatter.dateFormat = "EEEE"
    }
    
    // Link: https://www.healthline.com/health/fitness-exercise/how-many-calories-do-i-burn-a-day#calorie-calculator
    func compute_RMR()
    {
        self.RMR = Float(Float(self.coeff_RMR * self.user.weight) + Float(6.25 * Float(self.user.height)))
        self.RMR -= Float(Float(4.92) * Float(self.user.Age))
        
        if(self.user.gender == "Male")
        {
            self.RMR += self.coeff_RMR_Male
        }
        else
        {
            self.RMR -= self.coeff_RMR_Famale
        }
        
        self.RMR = self.RMR * self.coeff_Activity[self.user.Type_Activity]!
        
    }
    
    func get_Kcal_Daily() -> Float
    {
        self.compute_RMR()
        
        return self.RMR * self.coeff_Activity[self.user.Type_Activity]!
    }
    
    func get_Kcal_pedometer() -> Float
    {
        // -------------------- Formula to convert height to lenght step ---------------------
        var lenght_step : Float = 0.0
        
        if(self.user.gender == "Male")
        {
            lenght_step = Float(self.user.height) * self.coeff_step_lenght_male
        }
        else
        {
            lenght_step = Float(self.user.height) * self.coeff_step_lenght_famale
        }
        
        // -------------------- Convert numbers of steps to miles -----------------------------
        let one_mile_steps : Int = Int(160934 / lenght_step)
        
        let mile_distance : Float = Float(self.steps_counter) / Float(one_mile_steps)
        
        // ------------------------------ Walking VO2 -----------------------------------------
        let speed : Float = 0.1
        let grade : Float = 0.0
        
        let VO2 : Float = (speed * 0.1) + (speed*grade+1.8) + 3.5
        
        // Walking calories per minute (kcal/min) = ((VO2 * weight(kg)) / 1000) * 5
        let walking_kcal_min : Float = (((VO2 * Float(self.user.weight)) / Float(1000)) * Float(5))
        
        let duration_1000steps_min : Float = 9.8
        
        let cal_step : Float = (duration_1000steps_min * walking_kcal_min) / 1000.0
        
        return Float(Float(self.steps_counter) * cal_step)
        
    }
    
    func actual_cal_day() -> Float
    {
        let formatter = DateFormatter()
        
        formatter.locale = .current
        formatter.dateFormat = "EEEE"
        
        let cal_day : Float = self.get_Kcal_Daily() + self.get_Kcal_pedometer()
        
        var cal_sport : Float = 0.0
        
        for i in 0..<user.workouts.count
        {
            let workout = user.workouts[i]
            
            let name_today : String = formatter.string(from: Date())
            
            if name_today == workout.days[workout.Day]
            {
                let sport : Sport = Sport(type_of_sport: user.Type_of_Sport)
                
                cal_sport += sport.get_cal_sport(user: user, intensity: workout.IntensityOfLevel[workout.Intesity_Level], startTime: workout.Start_Time, endTime: workout.End_Time)
            }
        }
        
        return cal_day + cal_sport
    }
    
    func add_new_historical_data()
    {
        let obj = Table_Cal_Daily(context: CoreDataManager.persistentContainer!.viewContext)
        
        obj.date = Date()
        
        var dataTimeComponets = self.userCalendar.dateComponents(self.requestedComponents, from: obj.date!)
        
        dataTimeComponets.hour! = 0
        dataTimeComponets.minute! = 0
        dataTimeComponets.second! = 0
        
        obj.name_day! = obj.date == nil ? "" : self.formatter.string(from: obj.date!)
        
        obj.cal_daily = self.get_Kcal_Daily()
        
        obj.cal_sport = self.get_Kcal_pedometer()
        
        Table_Cal_Daily.save_item_on_CoreData()
    }
}
