//
//  InsertData.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct InsertData: View
{
    
    @EnvironmentObject var UserAPP : User
    
    @Binding var nameSport : String
    
    @State var nickname: String = ""
    @State var weight: String = ""
    @State var height: String = ""
    @State var number_workout: String = ""
    
    var dictSports : [String: Any] = ["Football": Football().real_CoeffSport(),
                                      "Tennis": Tennis().real_CoeffSport(),
                                      "Basket": Basket().real_CoeffSport(),
                                      "Volleyball": Volleyball().real_CoeffSport()]
    
    @State var changeView : Bool = false
    
    func checkFieds()
    {
        if (self.nickname != "")
        {
            let int_weight : Float = Float(self.weight) ?? 0.0
            let float_height : Int = Int(self.height) ?? 0
            
            if(float_height > 0 && int_weight > 0.0)
            {
                let int_n_workouts : Int = Int(self.number_workout) ?? 0
                
                if(int_n_workouts > 0)
                {
                    self.UserAPP.nickname = self.nickname
                    self.UserAPP.weight = int_weight
                    self.UserAPP.height = float_height
                    self.UserAPP.Type_of_Sport = self.setSport()
                    
                    AddWorkout()
                }
            }
        }
    }
    
    func setSport() -> Sport
    {
        return self.dictSports[nameSport] as! Sport
    }
    
    var body: some View{
        
        GeometryReader
        {
            geometry in
        
            NavigationView
            {
                Form
                {
                    TextField("Nickname",text: $nickname)
                    TextField("Height",text: $height)
                    TextField("Weight", text: $weight)
                    TextField("Number of Workout", text: $number_workout)
                }
            
                .navigationBarTitle("Insert your data")
            }
            
            ButtonNext(changeView: $changeView)
                .position(x: geometry.size.width/2, y: (geometry.size.height)-60)
        }
        
        if(changeView == true)
        {
            checkFieds()
        }
        
    }
}

struct InsertData_Previews: PreviewProvider {
    
    @StateObject static var UserAPP : User = User()
    @State static var nameSport : String = "Football"
    
    static var previews: some View
    {
        InsertData(nameSport: $nameSport)
            .environmentObject(UserAPP)
    }
}
