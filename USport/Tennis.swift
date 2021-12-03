//
//  Tennis.swift
//  USport
//
//  Created by Ciro Testa on 03/12/21.
//

import Foundation


class Tennis : Sport
{
    override func real_CoeffSport()
    {
        self.Coeff_Kcal_Low = 6.0
        self.Coeff_Kcal_Medium = 6.5
        self.Coeff_Kcal_High = 7.0
        self.Img_Icon = "Tennis_icon"
    }
}
