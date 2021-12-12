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
    
    @Published var Type_of_Sport : String
    
    @Published var gender : String
    
    @Published var Age : Int
    
    @Published var Type_Activity : String
    
    var type_of_gender : [String] = ["Male", "Famale"]
    
    var type_of_activity : [String] = ["Sedentary lifestyle", "Slightly active", "Moderately active", "Active lifestyle", "Very active lifestyle"]
    
    init()
    {
        self.nickname = "Default"
        self.height = 0
        self.weight = 0.0
        self.Type_of_Sport = "Football"
        self.Age = 0
        self.Type_Activity = "Sedentary lifestyle"
        self.gender = "Male"
    }
    
    init(nickname : String, age: Int, gender: String, activity : String, height : Int, weight : Float, type_of_sport : Sport)
    {
        self.nickname = "Default"
        self.height = 0
        self.weight = 0.0
        self.Type_of_Sport = "Football"
        self.Age = 0
        self.Type_Activity = "Sedentary lifestyle"
        self.gender = "Male"
    }
    
    init(n_workout : Int)
    {
        self.nickname = "Default"
        self.height = 0
        self.weight = 0.0
        self.Type_of_Sport = "Football"
        self.Age = 0
        self.Type_Activity = "Sedentary lifestyle"
        self.gender = "Male"
        
        self.create_n_workouts(n_workouts: n_workout)
    }
    
    func load_UserCoreData(usr : UserCoreData?)
    {
        self.nickname = usr!.nickname!
        
        self.Age = Int(usr!.age)
        
        self.gender = usr!.gender!
        
        self.height = Int(usr!.height)
        
        self.weight = usr!.weight
        
        self.Type_of_Sport = usr!.type_of_sport!
        
        self.Type_Activity = usr!.type_of_activity!
        
        self.workouts = usr!.workouts!.workouts
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
    
    func set_age(age : Int)
    {
        if(age > 8 && age < 120)
        {
            self.Age = age
        }
    }
    
    func set_type_of_activity(idx: Int)
    {
        self.Type_Activity = type_of_activity[idx]
    }
    
    func set_gender(idx: Int)
    {
        self.gender = type_of_gender[idx]
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
        self.Type_of_Sport = nameSport
    }
}
