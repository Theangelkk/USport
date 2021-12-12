//
//  Workouts.swift
//  USport
//
//  Created by Angelo Casolaro on 08/12/21.
//

import Foundation

public class Workouts : NSObject, NSSecureCoding
{
    public static var supportsSecureCoding: Bool = true
    
    public var workouts : [Workout] = [Workout]()
    
    enum Key : String
    {
        case workouts = "workouts"
    }
    
    init(workouts : [Workout])
    {
        self.workouts = workouts
    }
    
    public func encode(with coder: NSCoder)
    {
        coder.encode(workouts, forKey: Key.workouts.rawValue)
    }
    
    public required convenience init?(coder: NSCoder)
    {
        let mWorkouts = coder.decodeObject(of: [NSArray.self, Workout.self], forKey: Key.workouts.rawValue) as? [Workout]
        
        self.init(workouts: mWorkouts!)
    }
}
