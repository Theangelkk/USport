//
//  AddWorkout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct AddWorkout_Profile: View
{
    @Environment(\.presentationMode) var presentationMode
    
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
                    ForEach(0..<USportApp.UserAPP!.workouts.count)
                    {
                        idx in
                        ButtonWorkout_Profile(idx_workout: idx, titleButton: USportApp.UserAPP!.workouts[idx].Title)
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

struct AddWorkout_Profile_Previews: PreviewProvider
{
    @StateObject static var UserAPP : User = User(n_workout: 3)
    
    static var previews: some View
    {
        AddWorkout_Profile()
            .environmentObject(self.UserAPP)
    }
}

struct ButtonWorkout_Profile: View
{
    
    @State var idx_workout : Int
    var titleButton : String
    
    @State private var esit : Bool = false
    @State var workout : Workout = Workout()
    
    var body: some View {
        
        NavigationLink(destination: EditWorkout_Profile(new_workout: $workout, idx_workout: self.$idx_workout, name_workout: USportApp.UserAPP!.workouts[self.idx_workout].Title, daySelected: USportApp.UserAPP!.workouts[self.idx_workout].Day, intensitySelected: USportApp.UserAPP!.workouts[self.idx_workout].Intesity_Level, start: USportApp.UserAPP!.workouts[self.idx_workout].Start_Time, end: USportApp.UserAPP!.workouts[self.idx_workout].End_Time))
        {
            Text(self.titleButton)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20))
                .foregroundColor(Color.black)
        }
    }
}
