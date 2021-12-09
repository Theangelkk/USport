//
//  ActivityCoreData+CoreDataProperties.swift
//  USport
//
//  Created by Angelo Casolaro on 09/12/21.
//
//

import Foundation
import CoreData


extension ActivityCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityCoreData> {
        return NSFetchRequest<ActivityCoreData>(entityName: "ActivityCoreData")
    }

    @NSManaged public var type_of_sport: String?
    @NSManaged public var start_date: Date?
    @NSManaged public var end_date: Date?
    @NSManaged public var title: String?

}

extension ActivityCoreData : Identifiable {

}
