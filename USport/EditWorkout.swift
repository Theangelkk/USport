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
    
    @Binding var new_workout : Workout
    
    @Binding var idx_workout : Int
    @State  var name_workout: String
    
    @State var daySelected : Int
    @State var intensitySelected : Int
    
    @State var start : Date
    @State var end : Date
    
    var day = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var IntensityOfLevel = ["Low", "Medium", "High"]
        
    var body: some View
    {
        GeometryReader
        {
            // Mettere un immagine di sfondo
            
            geometry in
            
            Form
                {
                    Section(header: Text(""))
                    {
                        TextField("Workout", text: $name_workout)
                    }
                
                    Section(header: Text("Actions"))
                    {
                        Picker(selection: $daySelected, label: Text("Selected day")){
                    //Scorre l'array di giorni
                                ForEach(0 ..< day.count)
                                {
                                    Text(self.day[$0])
                                }
                            }
                
                        DatePicker("Start", selection: $start, displayedComponents: .hourAndMinute)
                        DatePicker("End", selection: $end, displayedComponents: .hourAndMinute)
                            
                        Picker(selection: $intensitySelected, label: Text("Intensity of Level"))
                                {
                                    //Scorre l'array dei livelli
                                    ForEach(0 ..< IntensityOfLevel.count)
                                    {
                                        Text(self.IntensityOfLevel[$0])
                                    }
                                }
                    }
                    
                } .accentColor(.red) //evidenzia il testo in rosso quando viene cliccato
            
                // Button Cancel
                .navigationBarBackButtonHidden(true)
            
                .navigationBarItems(leading: Button(action :
                {
                    self.adWorkout()
    
                    
                }){
                        Image(systemName: "arrow.left")
                })
                .navigationBarTitle(Text(name_workout), displayMode: .inline)
            }
    }
    
    // Magari con notifica se sbaglia ad inserire
    func adWorkout()
    {
        var esit_title : Bool = false
        var esit_endTime : Bool = false
        
        esit_title = new_workout.set_Title(title: self.name_workout)
        new_workout.set_Day(idx: self.daySelected)
        new_workout.set_IntensityOfLevel(idx: self.intensitySelected)
        new_workout.Start_Time = self.start
        esit_endTime = new_workout.set_EndTime(end: self.end)
    
        self.UserAPP.workouts[self.idx_workout] = new_workout
        
        let all_esit : Bool = esit_title && esit_endTime
        
        if(all_esit == true)
        {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}
 
struct EditWorkout_Previews: PreviewProvider {
    
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

