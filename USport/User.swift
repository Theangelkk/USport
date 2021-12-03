//
//  User.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation

class User : ObservableObject
{
    @Published var nickname : String
  
    @Published var height : Int
    
    @Published var weight : Float
    
    @Published var workouts = [Workout]()
    
    @Published var Type_of_Sport : Sport?
    
    init()
    {
        self.nickname = "Default"
        self.height = 0
        self.weight = 0.0
        self.Type_of_Sport = nil
    }
    
    init(nickname : String, height : Int, weight : Float, type_of_sport : Sport)
    {
        self.nickname = nickname
        self.height = height
        self.weight = weight
        self.Type_of_Sport = type_of_sport
    }
    
    func add_workout(workout : Workout)
    {
        self.workouts.append(workout)
    }
    
    func get_n_workouts() -> Int
    {
        return self.workouts.count
    }
}
