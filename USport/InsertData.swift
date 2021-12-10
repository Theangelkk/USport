//
//  InsertData.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI
import SwiftUICharts
import UserNotificationsUI

struct InsertData: View
{
    @EnvironmentObject var managerUser : ManagerUser
    
    @StateObject var delegate = Notification()
    
    @Binding var nameSport : String
    
    @State var nickname: String = ""
    @State var weight: String = ""
    @State var height: String = ""
    @State var number_workout: String = ""
    
    @State var changeView : Bool = false
    
    @State var idx_gender : Int = 0
    @State var idx_activity : Int = 0
    @State var age : String = ""
    
    func checkFieds()
    {
        var esit : Bool = false
        
        if (self.nickname != "")
        {
            let float_weight : Float = Float(self.weight) ?? 0.0
            let int_height : Int = Int(self.height) ?? 0
            
            if(int_height > 0 && int_height < 270 && float_weight > 0.0 && float_weight < 250.0)
            {
                let int_n_workouts : Int = Int(self.number_workout) ?? 0
                
                if(int_n_workouts > 0 && int_n_workouts < 8)
                {
                    let int_age : Int = Int(self.age) ?? 0
                    
                    if(int_age > 10 && int_age < 120)
                    {
                        changeView = managerUser.UserAPP.set_nickname(nick: self.nickname)
                        
                        managerUser.UserAPP.set_weight(weight: float_weight)
                        managerUser.UserAPP.set_height(height: int_height)
                        managerUser.UserAPP.create_n_workouts(n_workouts: int_n_workouts)
                        
                        managerUser.UserAPP.addSport(nameSport: self.nameSport)
                        
                        managerUser.UserAPP.set_gender(idx: idx_gender)
                        
                        managerUser.UserAPP.set_type_of_activity(idx: idx_activity)
                        
                        managerUser.UserAPP.set_age(age: int_age)
                        
                        esit = true
                    }
                }
            }
        }
        
        if esit == false
        {
            delegate.createNotification()
        }
    }
    
    var body: some View{
        
        GeometryReader
        {
            // Mettere un immagine di sfondo
            
            geometry in
        
            NavigationView
            {
                Form
                {
                    TextField_Elem(name_image: "nick", init_text: "Nickname", text: $nickname, geometry: geometry)
                    
                    
                    HStack (alignment: .center, spacing: 15)
                    {
                        Image_t(Image_name: "sex")
                        
                        Picker(selection: $idx_gender, label: Text("Gender"))
                        {
                            
                            ForEach(0..<managerUser.UserAPP.type_of_gender.count)
                            {
                                Text(managerUser.UserAPP.type_of_gender[$0])
                                    .font(.system(size: 17))
                            }
                        }
                    }
                    .padding(.vertical, 5.0)
                    
                    TextField_Elem(name_image: "age", init_text: "Age", text: $age, geometry: geometry)
                    
                    TextField_Elem(name_image: "height", init_text: "Height", text: $height, geometry: geometry)
                    
                    TextField_Elem(name_image: "weight", init_text: "Weight", text: $weight, geometry: geometry)
                    
                    HStack (alignment: .center, spacing: 15)
                    {
                            Image_t(Image_name: "level")
                        
                        Picker(selection: $idx_activity, label: Text("Activity"))
                            {
                                ForEach(0..<managerUser.UserAPP.type_of_activity.count)
                                {
                                    Text(managerUser.UserAPP.type_of_activity[$0])
                                        .font(.system(size: 17))
                                }
                            }
                    }
                    .padding(.vertical, 5.0)
                    
                    TextField_Elem(name_image: "workout", init_text: "workout", text: $number_workout, geometry: geometry)
                    
                }
                .navigationBarTitle("Insert your data")
            }
            
            Button(action:
            {
                self.checkFieds()
            })
            {
                Text("Next")
                    .font(.system(size: 15))
                    .fontWeight(.heavy)
            }
            .buttonStyle(CustomButtonStyle())
            .position(x: geometry.size.width/2, y: (geometry.size.height)-60)
            .onAppear
            {
                delegate.requestAuthorization()
            }
            
            if(changeView == true)
            {
                AddWorkout()
                    .environmentObject(managerUser)
            }
        }
    }
}

struct Image_t : View {
    
    var Image_name : String
    
    var body: some View{
        
        Image(Image_name)
            .resizable()
            .frame(width: 30, height: 30, alignment: .center)
            .foregroundColor(.black)
            .frame(minWidth: 0, maxWidth: 30)
            .frame(minHeight: 0, maxHeight: 33)
    }
}

struct TextField_Elem: View
{
    var name_image : String
    var init_text : String
    @Binding var text : String
    
    var geometry : GeometryProxy
    
    var body: some View {
        HStack (alignment: .center, spacing: 15)
        {
            Image_t(Image_name: name_image)
            
            TextField (init_text, text: $text)
                .font(.system(size: 17))
        }
        .padding(.vertical, 5.0)
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
