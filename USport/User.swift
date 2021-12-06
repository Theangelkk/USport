//
//  User.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation

typealias Codable = Decodable & Encodable

class User : ObservableObject
{
    @Published var nickname : String
  
    @Published var height : Int
    
    @Published var weight : Float
    
    @Published var workouts : [Workout] = []
    
    @Published var Type_of_Sport : Sport?
    
    @Published var gender : String
    
    @Published var Age : Int
    
    @Published var Type_Activity : String
    
    let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    var path_Json_user : URL? = URL(fileURLWithPath: "prova")
    
    var io_dict : IO_Dictionary<UserEnc>? = nil
    
    var type_of_gender : [String] = ["Male", "Famale"]
    
    var type_of_activity : [String] = ["Sedentary lifestyle", "Slightly active", "Moderately active", "Active lifestyle", "Very active lifestyle"]
    
    init()
    {
        self.nickname = "Default"
        self.height = 0
        self.weight = 0.0
        self.Type_of_Sport = nil
        self.Age = 0
        self.Type_Activity = "Default"
        self.gender = "Default"
        
        
        
        self.path_Json_user = dir?.appendingPathComponent("User").appendingPathExtension("json")
        
        self.io_dict = IO_Dictionary<UserEnc>(newValue_path_dictionary: path_Json_user)
    }
    
    init(nickname : String, age: Int, gender: String, activity : String, height : Int, weight : Float, type_of_sport : Sport)
    {
        self.nickname = "Default"
        self.height = 0
        self.weight = 0.0
        self.Type_of_Sport = nil
        self.Age = 0
        self.Type_Activity = "Default"
        self.gender = "Default"
        
        self.path_Json_user = dir?.appendingPathComponent("User").appendingPathExtension("json")
        
        self.io_dict = IO_Dictionary<UserEnc>(newValue_path_dictionary: path_Json_user)
    }
    
    init(n_workout : Int)
    {
        self.nickname = "Default"
        self.height = 0
        self.weight = 0.0
        self.Type_of_Sport = nil
        self.Age = 0
        self.Type_Activity = "Default"
        self.gender = "Default"
        
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
        self.Type_of_Sport = Sport(type_of_sport: nameSport)
    }
    
    func encode_json()
    {

        let usr_enc : UserEnc = UserEnc(nickname: self.nickname, height: String(self.height), weight: String(self.weight), age: String(self.Age), gender: self.gender, type_activity: self.Type_Activity)
        
        let fileURL = dir?.appendingPathComponent("User").appendingPathExtension("json")
        let enc : IO_Dictionary = IO_Dictionary<UserEnc>(newValue_path_dictionary: fileURL)
        
        enc.write(obj: usr_enc)
         
    }
    func decode_json()
    {
        io_dict?.read()
    }
}

struct UserEnc: Codable
{
    var nickname : String = ""
    var height : String = ""
    var weight : String = ""
    var age: String = ""
    var gender: String = ""
    var type_activity: String = ""
    
    var workouts : [WorkoutEnc] = []
    
    var Type_of_Sport : SportEnc?
}
