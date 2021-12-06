//
//  User.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import Foundation

typealias Codable = Decodable & Encodable

let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

let fileURL = dir?.appendingPathComponent("User").appendingPathExtension("json")

struct UserEnc: Codable{
    var nickname : String = ""
    var height : String = ""
    var weight : String = ""
    var workout : String = ""
    
    
}

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
    
    func encode_json()
    {
        
        /*let usr: User = User(nickname: nickname,height: height, weight: weight, workout: workout)

        let usrenc: UserEnc = UserEnc(nickname: usr.nickname, height: usr.height, weight: usr.weight, workout: usr.workout)
         */
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode("usrenc") {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                do {
                    try jsonString.write(to: fileURL!, atomically: true, encoding: .utf8)
                } catch {
                    // Handle error
                }
            }
        }
    }
    func decode_json()
    {
        do {
                let data = try Data(contentsOf: fileURL!)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(UserEnc.self,from: data)
                print(jsonData)
                } catch {
                    print("error:\(error)")
                }
    }
    
}
