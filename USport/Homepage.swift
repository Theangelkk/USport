//
//  Homepage.swift
//  USport
//
//  Created by Alessandro Ferrara on 04/12/21.
//


//prendersi il giorno in modo dinamico al posto di calendario


import SwiftUI
import HealthKit

struct Homepage: View
{
    @EnvironmentObject var managerUser : ManagerUser
    @EnvironmentObject var healthStore : HealthKitManager
    
    @Binding var managerKcal : Manager_Kcal?
    
    @Binding var chose_period : Int
    @Binding var currentKcal : Float
    @Binding var totalKcal : Float
    
    var names_button_bar : [String] = ["Daily", "Weekly", "Monthty"]
    
    @Binding var buttonBar : ButtonBar?
    @State var firstTime : Bool = true
    
    var body: some View
    {
        GeometryReader
        {
            geometry in
            
            VStack
            {
                Spacer()

                Text("USport")
                    .foregroundColor(Color.blue)
                    .font(.system(size: 50))
                    .bold()
                    .position(x: geometry.size.width/2, y: geometry.size.height/14)
                    
                Picker("Which period do you want to evaluate", selection: $chose_period)
                {
                    ForEach(0..<self.names_button_bar.count)
                    {
                        i in Text(self.names_button_bar[i])
                        
                    }
                }
                .onChange(of: self.chose_period, perform:
                {
                    (value) in
                    buttonBar!.onChange(value)
                    
                })
                .onAppear { buttonBar!.onChange(0) }
                .pickerStyle(.segmented)

                .position(x: geometry.size.width/2.1, y: -geometry.size.height/3.5)

                .frame(width: geometry.size.width - 15, height: geometry.size.height/90)

                Ring_Graph(geometry: geometry, currentKcal: $currentKcal, totalKcal: $totalKcal)

                .shadow(color: Color.black.opacity(0.30), radius: 5, x: 5, y: 10)
            }
        }
        .onAppear
        {
            if firstTime
            {
                managerKcal!.save_days_past()
                firstTime = false
            }
        }
    }
}

struct Ring_Graph: View
{
    var currentKcal : Binding<Float>
    var totalKcal : Binding<Float>
    
    var geometry : GeometryProxy
    
    init(geometry : GeometryProxy, currentKcal : Binding<Float>, totalKcal : Binding<Float>)
    {
        self.geometry = geometry
        self.currentKcal = currentKcal
        self.totalKcal = totalKcal
    }
    
    var body: some View
    {
        ZStack
        {
            // Complete Circle
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.black.opacity(0.10), lineWidth: 10)
                .frame(width: geometry.size.width/1.3,
                       height: geometry.size.height)
                .position(x: geometry.size.width/1.1, y: geometry.size.height/4.2)
        
            Circle()
                .trim(from: 0, to: CGFloat( self.currentKcal.wrappedValue / self.totalKcal.wrappedValue ) )
                .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .frame(width: geometry.size.width/1.3,
                       height: geometry.size.height)
                .position(x: geometry.size.width/1.1, y: geometry.size.height/4.2)
            
            
            Text("\(String(format: "%.1f", CGFloat( self.currentKcal.wrappedValue / self.totalKcal.wrappedValue ) * CGFloat(100)))%")
                .font(.system(size: 75))
                .foregroundColor(.black)
                .fontWeight(.bold)
                .position(x: geometry.size.width/1.9, y: -geometry.size.height/25)
                .rotationEffect(.init(degrees: 90))
            
            let actual_cal : Int = Int(self.currentKcal.wrappedValue)
            let total_cal : Int = Int(self.totalKcal.wrappedValue)
            
            Text("\(actual_cal) / \(total_cal) cal")
                .font(.system(size: 28))
                .foregroundColor(.black)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .position(x: geometry.size.width/1.9, y: geometry.size.height/10)
                .rotationEffect(.init(degrees: 90))
        }
        .rotationEffect(.init(degrees: -90))
    }
    
    func getPercent(Current : CGFloat, Goal : CGFloat) -> String
    {
        let per = CGFloat( Current / Goal) * 100
        
        return String(format: "%.1f", per)
    }

}

struct ButtonBar
{
    @Binding var currentKcal : Float
    @Binding var totalKcal : Float
    @Binding var managerKcal : Manager_Kcal?
    
    var idx : Int = 0
    
    func onChange(_ tag: Int)
    {
        currentKcal = managerKcal!.actual_cal_day()
        
        totalKcal = Table_Cal_Daily.average_cal_days()
    }
}

/*
struct Homepage_Previews: PreviewProvider
{
    @StateObject static var managerUser: ManagerUser = ManagerUser()
    @StateObject static var healthStore: HealthKitManager = HealthKitManager()
   
    @State static var managerKcal : Manager_Kcal? = Manager_Kcal()
    
    @State static var chose_period = 0
    @State static var currentKcal : Float = 0.0
    @State static var totalKcal : Float = 0.0
    
    @State static var buttonBar : ButtonBar? = ButtonBar(currentKcal: $currentKcal, totalKcal: $totalKcal, managerKcal: $managerKcal)
    
    static var previews: some View
    {
        Homepage(managerKcal: $managerKcal, chose_period: $chose_period, currentKcal: $currentKcal, totalKcal: $totalKcal, buttonBar: $buttonBar)
            .environmentObject(managerUser)
            .environmentObject(healthStore)
    }
}
 */

