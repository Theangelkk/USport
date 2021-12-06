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
}

struct SportEnc: Codable_Sport
{
    var Coeff_Kcal_Low : String
    
    var Coeff_Kcal_Medium : String
    
    var Coeff_Kcal_High : String
    
    var Img_Icon : String
    
    var Name_Sport : String
    
    
}
