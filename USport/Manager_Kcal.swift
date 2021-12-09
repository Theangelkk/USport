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
    
    var healthStore: HealthStore?
    
    init(user : User)
    {
        self.user = user
        
        self.formatter.locale = .current
        self.formatter.dateFormat = "EEEE"
        
        self.healthStore = HealthStore()

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
    
    func get_Kcal_pedometer(steps : Int) -> Float
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
        
        let mile_distance : Float = Float(steps) / Float(one_mile_steps)
        
        // ------------------------------ Walking VO2 -----------------------------------------
        let speed : Float = 0.1
        let grade : Float = 0.0
        
        let VO2 : Float = (speed * 0.1) + (speed*grade+1.8) + 3.5
        
        // Walking calories per minute (kcal/min) = ((VO2 * weight(kg)) / 1000) * 5
        let walking_kcal_min : Float = (((VO2 * Float(self.user.weight)) / Float(1000)) * Float(5))
        
        let duration_1000steps_min : Float = 9.8
        
        let cal_step : Float = (duration_1000steps_min * walking_kcal_min) / 1000.0
        
        return Float(Float(steps) * cal_step)
    }
    
    func actual_cal_day(user : User) -> Float
    {
        let formatter = DateFormatter()
        
        formatter.locale = .current
        formatter.dateFormat = "EEEE"
        
        let steps : [Step] = self.steps_counter_HealthKit(n_days_prev: 1, end_date: Date())
        
        let cal_day : Float = self.get_Kcal_Daily() + self.get_Kcal_pedometer(steps: steps[0].count)
        
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
        
        let activities : [ActivityCoreData] = ActivityCoreData.activities_of_today()
        
        var cal_activities : Float = 0.0
        
        for i in 0..<activities.count
        {
            let sport_act = Sport(type_of_sport: activities[i].type_of_sport!)
            
            let start_time_act : Date = activities[i].start_date!
            let end_time_act : Date = activities[i].end_date!
            
            cal_activities += sport_act.get_cal_sport(user: user, intensity: "Medium", startTime: start_time_act, endTime: end_time_act)
        }
        
        return cal_day + cal_sport + cal_activities
    }
    
    func add_new_historical_data(date : Date, cal_daily : Float, cal_sport : Float, name_day : String)
    {
        let obj : Table_Cal_Daily = Table_Cal_Daily(context: CoreDataManager.persistentContainer!.viewContext)
        
        obj.date = date
        obj.name_day = name_day
        obj.cal_daily = cal_daily
        obj.cal_sport = cal_sport
        
        var dataTimeComponets = self.userCalendar.dateComponents(self.requestedComponents, from: obj.date!)
        
        dataTimeComponets.hour! = 0
        dataTimeComponets.minute! = 0
        dataTimeComponets.second! = 0
        
        obj.name_day! = obj.date == nil ? "" : self.formatter.string(from: obj.date!)
                
        Table_Cal_Daily.save_item_on_CoreData()
    }
    
    func steps_counter_HealthKit(n_days_prev : Int, end_date : Date) -> [Step]
    {
        var steps : [Step] = [Step]()
        
        if let healthStore = healthStore
        {
            healthStore.requestAuthorization
            {
                success in
                
                if success
                {
                    healthStore.calculateSteps
                    {
                        statisricsCollection in
                        
                        if let statisricsCollection = statisricsCollection
                        {
                            steps = healthStore.updateUIFromStatistics(statisricsCollection, n_days_prev: n_days_prev, end: end_date)
                        }
                    }
                }
            }
        }
        
        return steps
    }
    
    func save_days_past()
    {
        let formatter = DateFormatter()
        
        formatter.locale = .current
        formatter.dateFormat = "EEEE"
        
        let last_date_stored : Date = Table_Cal_Daily.get_last_date()
        var yesterday: Date
        {
            return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        }
        
        let diffs = Calendar.current.dateComponents([.year, .month, .day], from: last_date_stored, to: yesterday)
        
        var days : Int = 0
        
        days += Int(diffs.day!)
        days += Int(diffs.month! * 30)
        
        let steps : [Step] = self.steps_counter_HealthKit(n_days_prev: days, end_date: yesterday)
        
        var actual_date : Date = last_date_stored
        
        var total_cal_daily : Float = 0.0
        var total_cal_sport : Float = 0.0
        
        for i in 0..<days
        {
            actual_date = Calendar.current.date(byAdding: .day, value: +1, to: actual_date)!
            
            total_cal_daily += self.get_Kcal_Daily()
            
            total_cal_daily += self.get_Kcal_pedometer(steps: steps[i].count)
            
            for j in 0..<self.user.workouts.count
            {
                let name_day_sport = self.user.workouts[j].name_day()
                let name_today : String = formatter.string(from: actual_date)
                
                if name_today == name_day_sport
                {
                    let intensity = self.user.workouts[j].IntensityOfLevel[self.user.workouts[j].Intesity_Level]
                    
                    let sport = Sport(type_of_sport: self.user.workouts[j].Type_of_Sport)
                    total_cal_sport += sport.get_cal_sport(user: user, intensity: intensity, startTime: self.user.workouts[j].Start_Time, endTime: self.user.workouts[j].End_Time)
                }
                
                self.add_new_historical_data(date: actual_date, cal_daily: total_cal_daily, cal_sport: total_cal_sport, name_day: name_today)
            }
        }
    }
}
