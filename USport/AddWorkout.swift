//
//  AddWorkout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct AddWorkout: View
{
    @EnvironmentObject var managerUser : ManagerUser
    
    @State var changeView : Bool = false
    @State var nameWorkout : String = ""
    
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
                        ForEach(0..<managerUser.UserAPP.workouts.count, id:\.self)
                        {
                            idx in
                            ButtonWorkout(workouts: $managerUser.UserAPP.workouts, idx_workout: idx, titleButton: managerUser.UserAPP.workouts[idx].Title)
                        }
                    }
                }
                .navigationBarTitle("Add your workouts")
                .toolbar
                {
                    ToolbarItemGroup(placement: .navigationBarTrailing)
                    {
                        Button(action:
                        {
                            changeView = true
                            
                            UserCoreData.save_user_on_CoreData(user: managerUser.UserAPP, delete_old: true)
                        })
                        {
                            Text("Done")
                        }
                    }
                }
            }
            
            if(changeView == true)
            {
                Dashboard()
                    .environmentObject(managerUser)
            }
        }
    }
}

struct ButtonWorkout: View
{
    @EnvironmentObject var managerUser : ManagerUser
    
    @Binding var workouts : [Workout]
    
    @State var idx_workout : Int
    var titleButton : String
    
    @State var new_workout : Workout = Workout()
        
    @State private var esit : Bool = false
    
    var body: some View
    {
        NavigationLink(destination: EditWorkout(new_workout : $new_workout, name_workout_tmp: workouts[self.idx_workout].Title, daySelected_tmp: workouts[self.idx_workout].Day, intensitySelected_tmp: workouts[self.idx_workout].Intesity_Level, start_tmp: workouts[self.idx_workout].Start_Time, end_tmp: workouts[self.idx_workout].End_Time))
        {
            Text(workouts[self.idx_workout].Title)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20))
                .foregroundColor(Color.black)
        }
        .onAppear
        {
            managerUser.UserAPP.workouts[idx_workout] = new_workout
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
