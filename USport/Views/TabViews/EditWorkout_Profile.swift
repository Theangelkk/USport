//
//  EditWorkout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct EditWorkout_Profile: View
{
    @Environment(\.presentationMode) var presentationMode
        
    @Binding var new_workout : Workout
    
    @State var name_workout_tmp: String = ""
    
    @State var daySelected_tmp : Int = 0
    @State var intensitySelected_tmp : Int = 0
    
    @State var start_tmp : Date = Date()
    @State var end_tmp : Date = Date()
    
    @State var firstTime : Bool = true
    
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
                        TextField("Workout", text: $name_workout_tmp)
                    }
                
                    Section(header: Text("Actions"))
                    {
                        Picker(selection: $daySelected_tmp, label: Text("Selected day"))
                        {
                            ForEach(0..<day.count)
                            {
                                Text(self.day[$0])
                            }
                        }
                
                        DatePicker("Start", selection: $start_tmp, displayedComponents: .hourAndMinute)
                        
                        DatePicker("End", selection: $end_tmp, displayedComponents: .hourAndMinute)
                            
                        Picker(selection: $intensitySelected_tmp, label: Text("Intensity of Level"))
                            {
                                ForEach(0..<IntensityOfLevel.count)
                                {
                                    Text(self.IntensityOfLevel[$0])
                                }
                            }
                    }
                
                }
                .accentColor(.red)
                
                // Button Cancel
                .navigationBarBackButtonHidden(true)
            
                .navigationBarItems(leading: Button(action :
                {
                    self.editWorkout()

                }){
                        Image(systemName: "arrow.left")
                })
                .navigationBarTitle(Text(name_workout_tmp), displayMode: .inline)
            
                /*
                if self.workouts.count > 1
                {
                    ButtonDelete(workouts: $workouts, idx: idx_workout, changeView: $changeView)
                    
                        .position(x: geometry.size.width/2, y: geometry.size.height/1.8)
                }*/
            }
             
    }

    func editWorkout()
    {
        var esit_title : Bool = false
        var esit_endTime : Bool = false
          
        esit_title = new_workout.set_Title(title: self.name_workout_tmp)
        
        new_workout.set_Day(idx: self.daySelected_tmp)
        
        new_workout.set_IntensityOfLevel(idx: self.intensitySelected_tmp)
        
        new_workout.Start_Time = self.start_tmp
        
        esit_endTime = new_workout.set_EndTime(end: self.end_tmp)
            
        let all_esit : Bool = esit_title && esit_endTime
        
        if(all_esit == true)
        {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ButtonDelete: View
{
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var workouts : [Workout]
    
    var idx : Int
    
    @Binding var changeView : Bool
    
    var body: some View
    {
        Button(action: {
            
            workouts.remove(at: idx)
            self.presentationMode.wrappedValue.dismiss()
            
        })
        {
            Text("Delete")
                .font(.system(size: 25))
                .fontWeight(.heavy)
        }
        .buttonStyle(CustomButtonStyle_Delete())
    }
}

/*
    Custom Design "Next" Button
 */
struct CustomButtonStyle_Delete: ButtonStyle
{
    private struct CustomButtonStyleView<V: View>: View
    {
        @State private var isOverButton = false

        let content: () -> V

        var body: some View
        {
            ZStack
            {
                content()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .shadow(color: Color.black, radius: 20, x: 5, y: 5)
            }
            .padding(3)
            .onHover
            {
                over in
                
                self.isOverButton = over
            }
            .overlay(
                VStack
                {
                    if self.isOverButton
                    {
                        Rectangle()
                            .stroke(Color.blue, lineWidth: 2)
                    } else
                    {
                        EmptyView()
                    }
            })
        }
    }

    func makeBody(configuration: Self.Configuration) -> some View
    {
        CustomButtonStyleView { configuration.label }
    }
}

/*
struct EditWorkout_Profile_Previews: PreviewProvider
{
    @StateObject static var UserAPP : User = User(n_workout: 1)
    @State static var nameSport : String = "Football"
    
    static var idx : Int = 0
    @State static var workout : Workout = Workout()
    
    static var previews: some View
    {
        EditWorkout_Profile(idx_workout: idx, name_workout: self.UserAPP.workouts[0].Title, daySelected: self.UserAPP.workouts[0].Day, intensitySelected: self.UserAPP.workouts[0].Intesity_Level, start: self.UserAPP.workouts[0].Start_Time, end: self.UserAPP.workouts[0].End_Time)
            .environmentObject(UserAPP)
    }
}
*/
