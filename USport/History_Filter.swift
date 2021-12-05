//
//  History_Filter.swift
//  USport
//
//  Created by Angelo Casolaro on 05/12/21.
//

import SwiftUI

struct History_Filter: View {
    
    @State var selectedDate = Date()

    var rkManager1 = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 1)
    
    @State var singleIsPresented = false
    
    @Environment(\.presentationMode) var presentationMode
    
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
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }
    
    func saveDate()
    {
        print("pippo")
        print(self.getTextFromDate(date: self.rkManager1.startDate))
              
        print(self.getTextFromDate(date: self.rkManager1.endDate))
    }
}

struct History_Filter_Previews: PreviewProvider {
    static var previews: some View {
        History_Filter()
    }
}
