//
//  Football.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation


class Football : Sport
{
    override func real_CoeffSport()
    {
        self.Coeff_Kcal_Low = 7
        self.Coeff_Kcal_Medium = 7.5
        self.Coeff_Kcal_High = 8
        self.Img_Icon = "Football_icon"
    }
}
