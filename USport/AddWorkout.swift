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
    
    @State var changeView : Bool = false
    
    var body: some View
    {
        GeometryReader
        {
            geometry in
            
            NavigationView
            {
                Section
                {
                    List
                    {
                        ForEach(0..<self.UserAPP.workouts.count)
                        {
                            idx in
                            ButtonWorkout(idx_workout: idx, titleButton: "Workout \(idx+1)")
                            
                        }
                    }
                }
                .navigationBarTitle("Add your workouts")
                
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing)
                    {
                        Button(action:
                        {
                            changeView = true
                        })
                        {
                            Text("Done")
                        }
                    }
                }
            }
            
            if(changeView == true)
            {
                Homepage()
            }
        }
    }
}

struct AddWorkout_Previews: PreviewProvider
{
    @StateObject static var UserAPP : User = User(n_workout: 3)
    
    static var previews: some View
    {
        AddWorkout()
            .environmentObject(self.UserAPP)
    }
}

struct ButtonWorkout: View
{
    
    @State var idx_workout : Int
    var titleButton : String
    
    @EnvironmentObject var UserAPP : User
    
    @State private var esit : Bool = false
    
    var body: some View {
        NavigationLink(destination:
                        EditWorkout(idx_workout: $idx_workout, workout: self.UserAPP.workouts[self.idx_workout].Title ))
        {
            Text(self.titleButton)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20))
                .foregroundColor(Color.black)
        }
    }
}
