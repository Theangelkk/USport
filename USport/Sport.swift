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
        self.Coeff_Kcal_Low = 0.0
        self.Coeff_Kcal_Medium = 0.0
        self.Coeff_Kcal_High = 0.0
        self.Img_Icon = "Default"
        
        self.Name_Sport = "Default"
    }
    
    init(newValue_Coeff_Low: Float, newValue_Coeff_Medium : Float, newValue_Coeff_High : Float, newValue_Icon : String, newValue_NameSport : String)
    {
        self.Coeff_Kcal_Low = newValue_Coeff_Low
        self.Coeff_Kcal_Medium = newValue_Coeff_Medium
        self.Coeff_Kcal_High = newValue_Coeff_High
        self.Img_Icon = newValue_Icon
        
        self.Name_Sport = "Default"
    }
    
    func real_CoeffSport()
    {
        preconditionFailure("This method must be overridden")
    }
}
