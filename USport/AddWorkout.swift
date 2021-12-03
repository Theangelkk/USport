//
//  AddWorkout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct AddWorkout: View
{
    @EnvironmentObject var UserAPP : User
    
    var pippo : Workout = Workout()
    
    var body: some View
    {
        GeometryReader
        {
            geometry in
            
            NavigationView
            {
                
                Text("Add your workouts")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 30))
                    .foregroundColor(Color.blue)
                    .padding(.vertical, 20.0)
     
                Section
                {
                    List
                    {
                        ButtonWorkout(titleButton: "1")
                        ButtonWorkout(titleButton: "2")
                    }
                    
                }
                .padding(.top, 60.0)
            }
        }
    }
}

struct AddWorkout_Previews: PreviewProvider {
    
    static var previews: some View
    {
        AddWorkout()
            .environmentObject(User())
    }
}

struct ButtonWorkout: View
{
    var titleButton : String
    
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/)
        {
            Text(self.titleButton)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20))
                .foregroundColor(Color.black)
        }
    }
}
