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
    @State private var daySelected = 0
    @State private var start = Date()
    @State private var end = Date()
    
    var body: some View {
        NavigationView {
        GeometryReader{ geometry in
            Form{
                Section {
                TextField("Workout", text: $workout)

                    
                Picker(selection: $daySelected, label: Text("Selected day")){
                    
                    ForEach(0 ..< day.count){
                        
                        Text(self.day[$0])
                        }
                }
                
                    
                
                DatePicker("Start", selection: $start, displayedComponents: .hourAndMinute)
                DatePicker("End", selection: $end, displayedComponents: .hourAndMinute)
                }
            } .navigationBarTitle(Text("day"), displayMode: .inline)
        }
    }
}

struct EditWorkout_Previews: PreviewProvider {
    static var previews: some View {
        EditWorkout()
    }
}
}
