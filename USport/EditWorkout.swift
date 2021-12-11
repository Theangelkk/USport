//
//  EditWorkout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct EditWorkout: View
{
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var workouts : [Workout]
    
    @Binding var idx_workout : Int
    
    @State var name_workout_tmp: String = ""
    @State var end_time_tmp : Date = Date()
        
    var day = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var IntensityOfLevel = ["Low", "Medium", "High"]
        
    var body: some View
    {
        GeometryReader
        {
            geometry in
            
            Form
                {
                    Section(header: Text(""))
                    {
                        TextField("Workout", text: $name_workout_tmp)
                    }
                
                    Section(header: Text("Actions"))
                    {
                        Picker(selection: $workouts[self.idx_workout].Day, label: Text("Selected day"))
                        {
                            ForEach(0..<day.count)
                            {
                                Text(self.day[$0])
                            }
                        }
                
                        DatePicker("Start", selection: $workouts[self.idx_workout].Start_Time, displayedComponents: .hourAndMinute)
                        
                        DatePicker("End", selection: $end_time_tmp, displayedComponents: .hourAndMinute)
                            
                        Picker(selection: $workouts[self.idx_workout].Intesity_Level, label: Text("Intensity of Level"))
                            {
                                ForEach(0..<IntensityOfLevel.count)
                                {
                                    Text(self.IntensityOfLevel[$0])
                                }
                            }
                    }
                    
                }
                .accentColor(.red)
            
                .onAppear
                {
                    self.name_workout_tmp = workouts[self.idx_workout].Title
                    self.end_time_tmp = workouts[self.idx_workout].End_Time
                }
            
                // Button Cancel
                .navigationBarBackButtonHidden(true)
            
                .navigationBarItems(leading: Button(action :
                {
                    self.adWorkout()
                }){
                        Image(systemName: "arrow.left")
                })
                .navigationBarTitle(Text(name_workout_tmp), displayMode: .inline)
            }
    }

    func adWorkout()
    {
        var esit_title : Bool = false
        var esit_endTime : Bool = false
          
        esit_title = workouts[self.idx_workout].set_Title(title: self.name_workout_tmp)
        
        esit_endTime = workouts[self.idx_workout].set_EndTime(end: self.end_time_tmp)
            
        let all_esit : Bool = esit_title && esit_endTime
        
        if(all_esit == true)
        {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

/*
struct EditWorkout_Previews: PreviewProvider
{
    @StateObject static var UserAPP : User = User(n_workout: 1)
    @State static var nameSport : String = "Football"
    
    @State static var idx : Int = 0
    @State static var workout : Workout = Workout()
    
    static var previews: some View
    {
        EditWorkout(new_workout: $workout, idx_workout: $idx, name_workout: self.UserAPP.workouts[0].Title, daySelected: self.UserAPP.workouts[0].Day, intensitySelected: self.UserAPP.workouts[0].Intesity_Level, start: self.UserAPP.workouts[0].Start_Time, end: self.UserAPP.workouts[0].End_Time)
            .environmentObject(UserAPP)
    }
}
*/
