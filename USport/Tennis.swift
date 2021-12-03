//
//  Tennis.swift
//  USport
//
//  Created by Ciro Testa on 03/12/21.
//

import Foundation


class Tennis : Sport
{
    override init(newValue_Coeff_Low: Float, newValue_Coeff_Medium: Float, newValue_Coeff_High: Float, newValue_Icon: String, newValue_NameSport: String)
    {
        super.init(newValue_Coeff_Low: newValue_Coeff_Low, newValue_Coeff_Medium: newValue_Coeff_Medium, newValue_Coeff_High: newValue_Coeff_High, newValue_Icon: newValue_Icon, newValue_NameSport: newValue_NameSport)
        
        self.Name_Sport = newValue_NameSport
    }
    
    override func real_CoeffSport()
    {
        self.Coeff_Kcal_Low = 6.0
        self.Coeff_Kcal_Medium = 6.5
        self.Coeff_Kcal_High = 7.0
        self.Img_Icon = "Tennis_icon"
    }
}
