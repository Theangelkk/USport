//
//  EditWorkout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct EditWorkout: View {
    @State private var workout: String = ""
    private var day = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State private var IntensityOfLevel = ["Low", "Medium", "High"]
    @State private var daySelected = 0
    @State private var intensitySelected = 0
    @State private var start = Date()
    @State private var end = Date()
    
    var body: some View {
        NavigationView {
        GeometryReader{ geometry in
            Form{
                Section(header: Text("")) {
                TextField("Workout", text: $workout)
                        
                }.navigationBarTitle(Text("Volleyball"), displayMode: .inline)
                
                Section(header: Text("Actions")) {
                Picker(selection: $daySelected, label: Text("Selected day")){
                    
                    ForEach(0 ..< day.count){
                        
                        Text(self.day[$0])
                    }.navigationBarTitle(Text("Day"), displayMode: .inline)
                        
                } 
                
                    DatePicker("Start", selection: $start, displayedComponents: .hourAndMinute)
                DatePicker("End", selection: $end, displayedComponents: .hourAndMinute)
                    
                    Picker(selection: $intensitySelected, label: Text("Intensity of Level")){
                        
                        ForEach(0 ..< IntensityOfLevel.count){
                            
                            Text(self.IntensityOfLevel[$0])
                        } .navigationBarTitle(Text("Intensity of Level"), displayMode: .inline)
                    }
                }
                .navigationBarTitle(Text("Volleyball"), displayMode: .inline)
            } .accentColor(.red)

                
        }
    }
}

struct EditWorkout_Previews: PreviewProvider {
    static var previews: some View {
        EditWorkout()
    }
}
}
