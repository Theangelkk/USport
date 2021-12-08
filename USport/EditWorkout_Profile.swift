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
    
    @Binding var idx_workout : Int
    @State  var name_workout: String
    
    @State var daySelected : Int
    @State var intensitySelected : Int
    
    @State var start : Date
    @State var end : Date
    
    @State var changeView : Bool = false
    
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
                    self.editWorkout()

                }){
                        Image(systemName: "arrow.left")
                })
                .navigationBarTitle(Text(name_workout), displayMode: .inline)
            
                if USportApp.UserAPP!.workouts.count > 1
                {
                    ButtonDelete(idx: idx_workout, changeView: $changeView)
                    .position(x: geometry.size.width/2, y: geometry.size.height/1.8)
                }
            }
    }
    
    // Magari con notifica se sbaglia ad inserire
    func editWorkout()
    {
        var esit_title : Bool = false
        var esit_endTime : Bool = false
        
        esit_title = new_workout.set_Title(title: self.name_workout)
        new_workout.set_Day(idx: self.daySelected)
        new_workout.set_IntensityOfLevel(idx: self.intensitySelected)
        new_workout.Start_Time = self.start
        esit_endTime = new_workout.set_EndTime(end: self.end)
    
        USportApp.UserAPP!.workouts[self.idx_workout] = new_workout
        
        let all_esit : Bool = esit_title && esit_endTime
        
        if(all_esit == true)
        {
            UserCoreData.save_user_on_CoreData(user: USportApp.UserAPP!, delete_old: true)
            
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}
 
struct EditWorkout_Profile_Previews: PreviewProvider
{
    @StateObject static var UserAPP : User = User(n_workout: 1)
    @State static var nameSport : String = "Football"
    
    @State static var idx : Int = 0
    @State static var workout : Workout = Workout()
    
    static var previews: some View
    {
        EditWorkout_Profile(new_workout: $workout, idx_workout: $idx, name_workout: self.UserAPP.workouts[0].Title, daySelected: self.UserAPP.workouts[0].Day, intensitySelected: self.UserAPP.workouts[0].Intesity_Level, start: self.UserAPP.workouts[0].Start_Time, end: self.UserAPP.workouts[0].End_Time)
            .environmentObject(UserAPP)
    }
}

struct ButtonDelete: View
{
    @Environment(\.presentationMode) var presentationMode
    
    var idx : Int
    
    @Binding var changeView : Bool
    
    var body: some View
    {
        Button(action: {
            
            USportApp.UserAPP!.workouts.remove(at: idx)
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

        var body: some View {
            ZStack {
                content()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .shadow(color: Color.black, radius: 20, x: 5, y: 5)
            }
            .padding(3)
            .onHover { over in
                self.isOverButton = over
                print("isOverButton:", self.isOverButton, "over:", over)
            }
            .overlay(VStack {
                if self.isOverButton {
                    Rectangle()
                        .stroke(Color.blue, lineWidth: 2)
                } else
                {
                    EmptyView()
                }
            })
        }
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        CustomButtonStyleView { configuration.label }
    }
}
