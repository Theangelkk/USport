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
    
    init(user : User)
    {
        self.user = user
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
        
        self.RMR * self.coeff_Activity[self.user.Type_Activity]!
        
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
        var one_mile_steps : Int = Int(160934 / lenght_step)
        
        var mile_distance : Float = Float(self.steps_counter) / Float(one_mile_steps)
        
        // ------------------------------ Walking VO2 -----------------------------------------
        var speed : Float = 0.1
        var grade : Float = 0.0
        
        var VO2 : Float = (speed * 0.1) + (speed*grade+1.8) + 3.5
        
        // Walking calories per minute (kcal/min) = ((VO2 * weight(kg)) / 1000) * 5
        var walking_kcal_min : Float = (((VO2 * Float(self.user.weight)) / Float(1000)) * Float(5))
        
        var duration_1000steps_min : Float = 9.8
        
        var cal_step : Float = (duration_1000steps_min * walking_kcal_min) / 1000.0
        
        return Float(Float(self.steps_counter) * cal_step) 
        
    }
}
