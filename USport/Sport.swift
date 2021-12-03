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
    
    init(newValue_Coeff_Low: Float, newValue_Coeff_Medium : Float, newValue_Coeff_High : Float, newValue_Icon : String)
    {
        self.Coeff_Kcal_Low = newValue_Coeff_Low
        self.Coeff_Kcal_Medium = newValue_Coeff_Medium
        self.Coeff_Kcal_High = newValue_Coeff_High
        self.Img_Icon = newValue_Icon
    }
    
    func real_CoeffSport()
    {
        preconditionFailure("This method must be overridden")
    }
}
