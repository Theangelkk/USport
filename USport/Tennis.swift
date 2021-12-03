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
        self.Coeff_Kcal_Low = 7
        self.Coeff_Kcal_Medium = 7.5
        self.Coeff_Kcal_High = 8
        self.Img_Icon = "Tennis_icon"
    }
}
