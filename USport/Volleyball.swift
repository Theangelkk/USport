//
//  Volleyball.swift
//  USport
//
//  Created by Ciro Testa on 03/12/21.
//

import Foundation


class Volleyball : Sport
{
    override init()
    {
        super.init()
        
        self.real_CoeffSport()
    }
    
    override init(newValue_Coeff_Low: Float, newValue_Coeff_Medium: Float, newValue_Coeff_High: Float, newValue_Icon: String, newValue_NameSport: String)
    {
        super.init(newValue_Coeff_Low: newValue_Coeff_Low, newValue_Coeff_Medium: newValue_Coeff_Medium, newValue_Coeff_High: newValue_Coeff_High, newValue_Icon: newValue_Icon, newValue_NameSport: newValue_NameSport)
        
        self.real_CoeffSport()
    }
    
    override func real_CoeffSport()
    {
        self.Coeff_Kcal_Low = 4.4
        self.Coeff_Kcal_Medium = 4.9
        self.Coeff_Kcal_High = 5.4
        self.Img_Icon = "Volleyball_icon"
        self.Name_Sport = "Volleyball"
    }
}
