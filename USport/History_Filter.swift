//
//  History_Filter.swift
//  USport
//
//  Created by Angelo Casolaro on 05/12/21.
//

import SwiftUI

struct History_Filter: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var dict_History : IO_Dictionary_History
    
    @State var selectedDate = Date()
    
    @Binding var Kcal_Daily : String
    @Binding var Kcal_Sport : String

    var rkManager1 = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 1)
    
    @State var singleIsPresented = false
        
    var body: some View
    {
        GeometryReader
        {
            geometry in
        
            RKViewController(isPresented: self.$singleIsPresented, rkManager: self.rkManager1)
                    
            Text(self.getTextFromDate(date: self.rkManager1.startDate))
            Text(self.getTextFromDate(date: self.rkManager1.endDate))
        }
        // Button Cancel
        .navigationBarBackButtonHidden(true)
    
        .navigationBarItems(leading: Button(action :
        {
            self.saveDate()
            self.presentationMode.wrappedValue.dismiss()
            
        }){
                Image(systemName: "arrow.left")
        })
        .navigationBarTitle("Chose dates", displayMode: .inline)
        
    }
    
    func getTextFromDate(date: Date!) -> String
    {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }
    
    func saveDate()
    {
        var startDate : String = self.getTextFromDate(date: self.rkManager1.startDate)
              
        var endDate : String = self.getTextFromDate(date: self.rkManager1.endDate)
        
        var res = self.dict_History.getKcal_RangeDate(startDate: startDate, endDate: endDate)
        
        self.Kcal_Daily = String(res.Total_Daily)
        self.Kcal_Sport = String(res.Total_Sport)
    }
}

struct History_Filter_Previews: PreviewProvider
{
    @StateObject static var dict_history : IO_Dictionary_History = IO_Dictionary_History(newValue_path_dictionary: "history.json")
    
    @State static var kcal_daily : String = "0"
    @State static var kcal_sport : String = "0"
    
    static var previews: some View
    {
        History_Filter(Kcal_Daily: self.$kcal_daily, Kcal_Sport: self.$kcal_sport)
            .environmentObject(dict_history)
    }
}
