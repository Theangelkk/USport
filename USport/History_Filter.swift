//
//  History_Filter.swift
//  USport
//
//  Created by Angelo Casolaro on 05/12/21.
//

import SwiftUI

struct History_Filter: View {
    
    @Environment(\.presentationMode) var presentationMode
 
    @State var selectedDate = Date()
    
    @Binding var items_days : [Double]
    @Binding var Kcal_Daily : String
    @Binding var Kcal_Sport : String

    var rkManager1 = RKManager(calendar: Calendar.current, minimumDate: Table_Cal_Daily.get_first_date(), maximumDate: Date(), mode: 1)
    
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
        var ris_all_cal : [Double] = [Double]()
        
        if self.rkManager1.startDate != nil && self.rkManager1.endDate != nil
        {
            let res = Table_Cal_Daily.range_cal_days(start_date: self.rkManager1.startDate, end_date: self.rkManager1.endDate)
            
            self.Kcal_Daily = String(res.Total_cal_daily)
            self.Kcal_Sport = String(res.Total_cal_sport)
            
            for i in 0..<res.list_objs.count
            {
                var sum : Double = 0.0
                
                sum += Double(res.list_objs[i].cal_daily)
                sum += Double(res.list_objs[i].cal_sport)
                
                ris_all_cal.append(sum)
            }
            
            self.items_days = ris_all_cal
        }
    }
}

struct History_Filter_Previews: PreviewProvider
{
    @State static var items : [Double] = [Double]()
    @State static var kcal_daily : String = "0"
    @State static var kcal_sport : String = "0"
    
    static var previews: some View
    {
        History_Filter(items_days: $items, Kcal_Daily: self.$kcal_daily, Kcal_Sport: self.$kcal_sport)
    }
}
