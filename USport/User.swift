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
    
    @Published var workouts : [Workout] = []
    
    @Published var Type_of_Sport : Sport?
    
    init()
    {
        self.nickname = "Default"
        self.height = 0
        self.weight = 0.0
        self.Type_of_Sport = nil
    }
    
    init(n_workout : Int)
    {
        self.nickname = "Default"
        self.height = 0
        self.weight = 0.0
        self.Type_of_Sport = nil
        
        self.create_n_workouts(n_workouts: n_workout)
    }
    
    init(nickname : String, height : Int, weight : Float, type_of_sport : Sport)
    {
        self.nickname = "Default"
        self.height = 0
        self.weight = 0.0
        self.Type_of_Sport = nil
        
        self.set_nickname(nick: nickname)
        self.set_height(height: height)
        self.set_weight(weight: weight)
        self.Type_of_Sport = type_of_sport
    }
    
    func set_nickname(nick : String) -> Bool
    {
        if(nick != "")
        {
            self.nickname = nick
            return true
        }
        
        return false
    }
    
    func set_height(height : Int)
    {
        if(height > 0 && height < 270)
        {
            self.height = height
        }
    }
    
    func set_weight(weight : Float)
    {
        if(weight > 0.0 && weight < 250.0)
        {
            self.weight = weight
        }
    }
    
    func create_n_workouts(n_workouts : Int)
    {
        self.workouts = []
        
        for _ in 1...n_workouts
        {
            self.add_workout(workout: Workout())
        }
    }
    
    func add_workout(workout : Workout)
    {
        self.workouts.append(workout)
    }
    
    func get_elem_workout(idx : Int) -> Workout
    {
        return self.workouts[idx]
    }
    
    func get_n_workouts() -> Int
    {
        return self.workouts.count
    }
    
    func addSport(nameSport : String)
    {
        self.Type_of_Sport = Sport(type_of_sport: nameSport)
    }
}
