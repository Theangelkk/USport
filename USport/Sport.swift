//
//  Sport.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation

typealias Codable_Sport = Decodable & Encodable

class Sport : ObservableObject
{
    @Published var Coeff_Kcal_Low : Float
    
    @Published var Coeff_Kcal_Medium : Float
    
    @Published var Coeff_Kcal_High : Float
    
    @Published var Img_Icon : String
    
    @Published var Name_Sport : String
    
    init()
    {
        self.Coeff_Kcal_Low = 0
        self.Coeff_Kcal_Medium = 0
        self.Coeff_Kcal_High = 0
        self.Img_Icon = ""
        self.Name_Sport = ""
        
        self.Football()
    }
    
    init(type_of_sport : String)
    {
        self.Coeff_Kcal_Low = 0
        self.Coeff_Kcal_Medium = 0
        self.Coeff_Kcal_High = 0
        self.Img_Icon = ""
        self.Name_Sport = ""
        
        if(type_of_sport == "Football")
        {
            self.Football()
        }
        else if(type_of_sport == "Tennis")
        {
            self.Tennis()
        }
        else if(type_of_sport == "Basket")
        {
            self.Basket()
        }
        else if(type_of_sport == "Volleyball")
        {
            self.Volleyball()
        }
    }
    
    func Football()
    {
        self.Coeff_Kcal_Low = 7
        self.Coeff_Kcal_Medium = 7.5
        self.Coeff_Kcal_High = 8
        
        self.Img_Icon = "Football_icon"
        self.Name_Sport = "Football"
    }
    
    func Basket()
    {
        self.Coeff_Kcal_Low = 7
        self.Coeff_Kcal_Medium = 7.5
        self.Coeff_Kcal_High = 8
        
        self.Img_Icon = "Basket_icon"
        self.Name_Sport = "Basket"
    }
    
    func Volleyball()
    {
        self.Coeff_Kcal_Low = 4.4
        self.Coeff_Kcal_Medium = 4.9
        self.Coeff_Kcal_High = 5.4
        
        self.Img_Icon = "Volleyball_icon"
        self.Name_Sport = "Volleyball"
    }
    
    func Tennis()
    {
        self.Coeff_Kcal_Low = 6.0
        self.Coeff_Kcal_Medium = 6.5
        self.Coeff_Kcal_High = 7.0
        
        self.Img_Icon = "Tennis_icon"
        self.Name_Sport = "Tennis"
    }
    
    func get_cal_sport(user : User, intensity : String, startTime : Date, endTime : Date) -> Float
    {
        let userCalendar : Calendar = Calendar.current
        
        let requestedComponents : Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second ]
        
        let coeff_male : Float = 1.10
        let coeff_famale : Float = 1.07
        
        let coeff_male_1 : Float = -128.0
        let coeff_famale_1 : Float = -148.0
        
        var lean_mass : Float = 0.0
        
        if(user.gender == "Male")
        {
            let v1 = Float(coeff_male * user.weight)
            let v2 = Float(pow(Float(user.weight/Float(user.height)), 2))
                           
            lean_mass = Float(v1 - coeff_male_1 *  v2)
        }
        else
        {
            lean_mass = Float(Float(coeff_famale * user.weight) - coeff_famale_1 * Float(pow(user.weight, 2) * Float(user.height)))
        }
        
        var cal_hour : Float = 0.0
        
        if(intensity == "Low")
        {
            cal_hour = self.Coeff_Kcal_Low * lean_mass
        }
        else if(intensity == "Medium")
        {
        
            cal_hour = self.Coeff_Kcal_Medium * lean_mass
        }
        else
        {
            cal_hour = self.Coeff_Kcal_High * lean_mass
        }
        
        let cal_min : Float = cal_hour / 60.0
        
        let dataTimeComponets_StartTime = userCalendar.dateComponents(requestedComponents, from: startTime)
        let dataTimeComponets_EndTime = userCalendar.dateComponents(requestedComponents, from: endTime)
        
        let diff_hour_in_min : Int = (dataTimeComponets_EndTime.hour! - dataTimeComponets_StartTime.hour!) * 60
        
        let diff_min : Int = (dataTimeComponets_EndTime.minute! - dataTimeComponets_StartTime.minute!)
        
        var all_cal = Float(diff_min + diff_hour_in_min) * cal_min
        
        return all_cal
        
    }
}

struct SportEnc: Codable_Sport
{
    var Coeff_Kcal_Low : String
    
    var Coeff_Kcal_Medium : String
    
    var Coeff_Kcal_High : String
    
    var Img_Icon : String
    
    var Name_Sport : String
}
