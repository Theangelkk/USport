//
//  UserCoreData+CoreDataProperties.swift
//  USport
//
//  Created by Angelo Casolaro on 08/12/21.
//
//

import Foundation
import CoreData


extension UserCoreData
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreData> {
        return NSFetchRequest<UserCoreData>(entityName: "UserCoreData")
    }

    @NSManaged public var nickname: String?
    @NSManaged public var height: Int64
    @NSManaged public var weight: Float
    @NSManaged public var type_of_sport: String?
    @NSManaged public var gender: String?
    @NSManaged public var age: Int64
    @NSManaged public var type_of_activity: String?
    @NSManaged public var workouts: Workouts?
}

extension UserCoreData : Identifiable
{

}
