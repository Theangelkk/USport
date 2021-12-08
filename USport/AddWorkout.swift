//
//  AddWorkout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct AddWorkout: View
{
    @State var changeView : Bool = false
    
    var body: some View
    {
        GeometryReader
        {
            // Mettere un immagine di sfondo
            
            geometry in
            
            NavigationView
            {
                Section
                {
                    List
                    {
                        ForEach(0..<USportApp.UserAPP!.workouts.count)
                        {
                            idx in
                            ButtonWorkout(idx_workout: idx, titleButton: USportApp.UserAPP!.workouts[idx].Title )
                            
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
                            
                            UserCoreData.save_user_on_CoreData(user: USportApp.UserAPP!, delete_old: true)
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
                    .environmentObject(USportApp.UserAPP!)
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
    @State var workout : Workout = Workout()
    
    var body: some View {
        
        NavigationLink(destination: EditWorkout(new_workout: $workout, idx_workout: self.$idx_workout, name_workout: self.UserAPP.workouts[self.idx_workout].Title, daySelected: self.UserAPP.workouts[self.idx_workout].Day, intensitySelected: self.UserAPP.workouts[self.idx_workout].Intesity_Level, start: self.UserAPP.workouts[self.idx_workout].Start_Time, end: self.UserAPP.workouts[self.idx_workout].End_Time))
        {
            Text(self.titleButton)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20))
                .foregroundColor(Color.black)
        }
    }
}
