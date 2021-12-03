//
//  Volleyball.swift
//  USport
//
//  Created by Ciro Testa on 03/12/21.
//

import Foundation


class Volleyball : Sport
{
    override func real_CoeffSport()
    {
        self.Coeff_Kcal_Low = 4.4
        self.Coeff_Kcal_Medium = 4.9
        self.Coeff_Kcal_High = 5.4
        self.Img_Icon = "Volleyball_icon"
    }
}
