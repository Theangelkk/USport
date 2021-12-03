//
//  EditWorkout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct EditWorkout: View {
    @State private var workout: String = ""
    private var day = ["Lunedi", "Martedi"]
    @State private var daySelected = ""
    @State private var start = Date()
    @State private var end = Date()
    
    var body: some View {
        GeometryReader{ geometry in
            Form{
                Section {
                TextField("Workout", text: $workout)
                    
                Picker("day", selection: $daySelected){
                    
                        ForEach(day, id:\.self){
                        
                            Text($0)
                        }
                } .pickerStyle(.menu)
                
                    
                
                DatePicker("Start", selection: $start, displayedComponents: .hourAndMinute)
                DatePicker("End", selection: $end, displayedComponents: .hourAndMinute)
                }
            }
        }
    }
}

struct EditWorkout_Previews: PreviewProvider {
    static var previews: some View {
        EditWorkout()
    }
}
