//
//  IO_Dictionary_History.swift
//  USport
//
//  Created by Angelo Casolaro on 06/12/21.
//

import Foundation

class IO_Dictionary_History : IO_Dictionary
{
    func getKcal_RangeDate(startDate : String, endDate : String) -> (Total_Daily : Float, Total_Sport : Float)
    {
        var Ktotal_Daily : Float = 0.0
        var Ktotal_Sport : Float = 0.0
        
        // Day, Day Mounth Year --> From JSON
        let dict : [String : [String]] = [
                                            "Saturday, 4 December 2021": ["1800","2100"],
                                            "Sunday, 5 December 2021": ["1000","2000"],
                                            "Monday, 6 December 2021": ["1200","2500"]
                                        ]
        
        for (_, values) in dict
        {
            let kcal_daily : Float = Float(values[0]) ?? 0.0
            let kcal_sport : Float = Float(values[1]) ?? 0.0
            
            Ktotal_Daily += kcal_daily
            Ktotal_Sport += kcal_sport
        }
        
        return (Ktotal_Daily,Ktotal_Sport)
    }
    
}
