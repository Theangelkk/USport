//
//  EditWorkout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct EditWorkout: View
{
    @EnvironmentObject var UserAPP : User
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var idx_workout : Int
    @State  var workout: String = "Workout"
    
    var day = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    @State var IntensityOfLevel = ["Low", "Medium", "High"]
    
    @State var daySelected = 0
    @State var intensitySelected = 0
    
    @State var start = Date()
    @State var end = Date()
    
    var body: some View
    {
        GeometryReader
        {
            geometry in
            
            Form
                {
                    Section(header: Text(""))
                    {
                        TextField("Workout", text: $workout)
                    }
                
                    Section(header: Text("Actions"))
                    {
                        Picker(selection: $daySelected, label: Text("Selected day")){
                    
                                ForEach(0 ..< day.count)
                                {
                                    Text(self.day[$0])
                                }
                            }
                
                        DatePicker("Start", selection: $start, displayedComponents: .hourAndMinute)
                        DatePicker("End", selection: $end, displayedComponents: .hourAndMinute)
                            
                        Picker(selection: $intensitySelected, label: Text("Intensity of Level"))
                                {
                                    ForEach(0 ..< IntensityOfLevel.count)
                                    {
                                        Text(self.IntensityOfLevel[$0])
                                    }
                                }
                    }
                    
                } .accentColor(.red)
            
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action :
                {
                    self.adWorkout()
                    self.presentationMode.wrappedValue.dismiss()
                    
                }){
                        Image(systemName: "arrow.left")
                })
                .navigationBarTitle(Text(workout), displayMode: .inline)
            }
    }
    
    func adWorkout()
    {
                
        self.UserAPP.workouts[self.idx_workout].Day = self.day[daySelected]
        self.UserAPP.workouts[self.idx_workout].Intesity_Level = IntensityOfLevel[intensitySelected]
        self.UserAPP.workouts[self.idx_workout].Start_Time = start
        self.UserAPP.workouts[self.idx_workout].End_Time = end
    
    }
}
 
struct EditWorkout_Previews: PreviewProvider {
    
    @StateObject static var UserAPP : User = User(n_workout: 1)
    @State static var nameSport : String = "Football"
    
    @State static var idx : Int = 0
    
    static var previews: some View
    {
        EditWorkout(idx_workout: $idx)
            .environmentObject(UserAPP)
    }
}

