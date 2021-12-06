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
    
    @State var changeView : Bool = false
    
    // Magari far uscire una notifica di errore
    func checkFieds()
    {
        if (self.nickname != "")
        {
            let float_weight : Float = Float(self.weight) ?? 0.0
            let int_height : Int = Int(self.height) ?? 0
            
            if(int_height > 0 && int_height < 270 && float_weight > 0.0 && float_weight < 250.0)
            {
                let int_n_workouts : Int = Int(self.number_workout) ?? 0
                
                if(int_n_workouts > 0 && int_n_workouts < 8)
                {
                    changeView = self.UserAPP.set_nickname(nick: self.nickname)
                    self.UserAPP.set_weight(weight: float_weight)
                    self.UserAPP.set_height(height: int_height)
                    self.UserAPP.create_n_workouts(n_workouts: int_n_workouts)
                    self.UserAPP.addSport(nameSport: self.nameSport)
                }
            }
        }
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
            
            Button(action:
            {
                self.checkFieds()
            })
            {
                Text("Next")
                    .font(.system(size: 25))
                    .fontWeight(.heavy)
            }
            .buttonStyle(CustomButtonStyle())
            .position(x: geometry.size.width/2, y: (geometry.size.height)-60)
            
            if(changeView == true)
            {
                AddWorkout()
            }
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
