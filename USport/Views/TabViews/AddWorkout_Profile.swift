//
//  AddWorkout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct AddWorkout_Profile: View
{
    @EnvironmentObject var managerUser : ManagerUser
    
    @Environment(\.presentationMode) var presentationMode
    
    var type_sport : String
    
    @State var firstTime : Bool = true
    
    @State var changeView : Bool = false

    var body: some View
    {
        GeometryReader
        {
            // Mettere un immagine di sfondo
            
            geometry in
            
            Section
            {
                List
                {
                    ForEach(0..<managerUser.UserAPP.workouts.count)
                    {
                        idx in
                        
                        ButtonWorkout_Profile(idx_workout: idx, workouts : $managerUser.UserAPP.workouts, type_sport: type_sport, new_workout : managerUser.UserAPP.workouts[idx])
                            .environmentObject(managerUser)
                    }
                }
            }
    
            // Button Cancel
            .navigationBarBackButtonHidden(true)
        
            .navigationBarItems(leading: Button(action :
            {
                self.presentationMode.wrappedValue.dismiss()
                
            }){
                    Image(systemName: "arrow.left")
            })
            
            .navigationBarTitle("Add your workouts")
        }
    }
}

struct ButtonWorkout_Profile: View
{
    @EnvironmentObject var managerUser : ManagerUser
    
    var idx_workout : Int
    @Binding var workouts : [Workout]
    
    var type_sport : String
    
    @State var new_workout : Workout
    
    @State private var esit : Bool = false
    @State var firstTime : Bool = true
    
    var body: some View
    {
        NavigationLink(destination: EditWorkout_Profile(new_workout : $new_workout, name_workout_tmp: workouts[self.idx_workout].Title, daySelected_tmp: workouts[self.idx_workout].Day, intensitySelected_tmp: workouts[self.idx_workout].Intesity_Level, start_tmp: workouts[self.idx_workout].Start_Time, end_tmp: workouts[self.idx_workout].End_Time))
        
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

/*
struct AddWorkout_Profile_Previews: PreviewProvider
{
    @StateObject static var UserAPP : User = User(n_workout: 3)
    
    static var previews: some View
    {
        AddWorkout_Profile()
            .environmentObject(self.UserAPP)
    }
}
*/
