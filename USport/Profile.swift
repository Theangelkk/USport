//
//  Profile.swift
//  USport
//
//  Created by Raffaele Calcagno on 05/12/21.
//

import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var UserAPP : User
    
    @State var dateOfBirth = Date()
    @State var sex = ["Male", "Female", "Unknown"]
    @State var workout = 3
    @State var weight = 0
    @State var height = 0
    @State var sexSelected = 0
    @State var shouldActivateNotifications = false
    
    var body: some View {
        
        GeometryReader
        {
            geometry in
            
            Form
            {
                Section(header: Text(""))
                {
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    
                    Picker(selection: $sexSelected, label: Text("Sex"))
                            {
                                ForEach(0 ..< sex.count)
                                {
                                    Text(self.sex[$0])
                                } .foregroundColor(.blue)
                            }
                    Toggle("Notifications", isOn: $shouldActivateNotifications)
                        .toggleStyle(SwitchToggleStyle(tint: .green))
                    HStack
                    {
                        Text("Workout")
                        Spacer()
                        //Workout è impostato a 3 solo per motivi di corretta visualizzazione, il numero reale è derivato da n_workouts di AddWorkout.swift //
                        Text("\(workout)")
                        Spacer()
                    }
                    HStack
                    {
                        Text("Weight")
                        Spacer()
                        //Workout è impostato a 3 solo per motivi di corretta visualizzazione, il numero reale è derivato da n_workouts di AddWorkout.swift //
                        Text("\(weight)Kg")
                        Spacer()
                    }
                    HStack
                    {
                        Text("Height")
                        Spacer()
                        //Workout è impostato a 3 solo per motivi di corretta visualizzazione, il numero reale è derivato da n_workouts di AddWorkout.swift //
                        Text("\(height)cm")
                        Spacer()
                    }
                    
                } .foregroundColor(.black)
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
