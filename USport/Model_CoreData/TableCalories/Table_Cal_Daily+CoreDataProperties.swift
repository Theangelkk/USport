//
//  Table_Cal_Daily+CoreDataProperties.swift
//  USport
//
//  Created by Angelo Casolaro on 07/12/21.
//
//

import Foundation
import CoreData


extension Table_Cal_Daily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Table_Cal_Daily> {
        return NSFetchRequest<Table_Cal_Daily>(entityName: "Table_Cal_Daily")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name_day: String?
    @NSManaged public var cal_daily: Float
    @NSManaged public var cal_sport: Float

}

extension Table_Cal_Daily : Identifiable {

}
