//
//  Sport.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation

class Sport
{
    internal var Coeff_Kcal_Low : Float
    {
        get
        {
            return self.Coeff_Kcal_Low
        }
        
        set(newValue_Coeff_Medium)
        {
            self.Coeff_Kcal_Medium = newValue_Coeff_Medium
        }
    }
    
    internal var Coeff_Kcal_Medium : Float
    {
        get
        {
            return self.Coeff_Kcal_Medium
        }
        
        set(newValue_Coeff_Medium)
        {
            self.Coeff_Kcal_Medium = newValue_Coeff_Medium
        }
    }
    
    internal var Coeff_Kcal_High : Float
    {
        get
        {
            return self.Coeff_Kcal_High
        }
        
        set(newValue_Coeff_High)
        {
            self.Coeff_Kcal_High = newValue_Coeff_High
        }
    }
    
    internal var Img_Icon : String
    {
        get
        {
            return self.Img_Icon
        }
        
        set(newValue_Icon)
        {
            self.Img_Icon = newValue_Icon
        }
    }
    
    internal var Name_Sport : String
    {
        get
        {
            return self.Name_Sport
        }
        
        set(newValue_NameSport)
        {
            self.Name_Sport = newValue_NameSport
        }
    }
    
    init()
    {
        self.Football()
    }
    
    init(type_of_sport : String)
    {
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
}
