//
//  EditActivity.swift
//  USport
//
//  Created by Alessandro Ferrara on 06/12/21.
//

import SwiftUI

struct EditActivity: View
{
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var nameSport : String
    
    @State var new_activity : Activity = Activity()
    
    @State  var name_activity: String = "Activity"
    
    @State var start : Date = Date()
    @State var end : Date = Date()
    
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
                    TextField("Activity", text: $name_activity)
                }
            
                Section(header: Text("Actions"))
                {
                    DatePicker("Start", selection: $start, displayedComponents: .hourAndMinute)
                    
                    DatePicker("End", selection: $end, displayedComponents: .hourAndMinute)
                }
            }
            
            // Button Cancel
            .navigationBarBackButtonHidden(true)
        
            .navigationBarItems(leading: Button(action :
            {
                addActivity()
                self.presentationMode.wrappedValue.dismiss()
                
            }){
                    Image(systemName: "arrow.left")
            })
            .navigationBarTitle(Text(nameSport), displayMode: .inline)
            
        }
        .accentColor(.red)
        
    }
    
    func addActivity()
    {
        var esit_title : Bool = false
        var esit_endTime : Bool = false
        
        esit_title = new_activity.set_Title(title: self.name_activity)
        
        new_activity.Start_Time = self.start
        
        esit_endTime = new_activity.set_EndTime(end: self.end)
        
        new_activity.Type_of_Sport = nameSport
    
        let all_esit : Bool = esit_title && esit_endTime
        
        if(all_esit == true)
        {
            ActivityCoreData.save_user_on_CoreData(activity: new_activity)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}
 
struct EditActivity_Previews: PreviewProvider
{
    @StateObject static var UserAPP : User = User(n_workout: 1)
    @State static var nameSport : String = "Football"
        
    static var previews: some View
    {
        EditActivity(nameSport: $nameSport)
    }
}

