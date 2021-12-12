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
    @Binding var currentKcal_normal : Float
    @Binding var currentKcal_sport : Float
    @Binding var totalKcal : Float
    @Binding var other_circle : Float
    @Binding var text : String
    
    @State var n_steps : Int = 100
    
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
                    .font(.system(size: 60))
                    .bold()
                    .frame(width: geometry.size.width, height: geometry.size.height/10, alignment: .center)
                    .position(x: geometry.size.width/2, y: geometry.size.height/16)
               
                Ring_Graph(geometry: geometry, currentKcal: $currentKcal, totalKcal: $totalKcal, other_circle: $other_circle, text: $text)
                
                
                ZStack
                {
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.blue, lineWidth: 3)
                        .frame(width: geometry.size.width - 30, height: geometry.size.height/3.3)
                        .position(x: geometry.size.width/2, y: geometry.size.height/2.6)
                    
                    HStack
                    {
                        Image("life_person")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/4.9, height: geometry.size.height/6)
                            
                    
                        Text("\(Int(self.currentKcal_normal)) cal")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .fontWeight(.bold)

                    }
                    .position(x: geometry.size.width/3.8, y: geometry.size.height/3.2)
                    
                    HStack
                    {
                        Image("omino_pallavolo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/6.5, height: geometry.size.height/6.5)
                        
                        Text("\(Int(self.currentKcal_sport)) cal")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                    }
                    .position(x: geometry.size.width/3.8, y: geometry.size.height/2.2)
                    
                    HStack
                    {
                        Image("step")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/4.8, height: geometry.size.height/4.5)
                        
                        Text("\(self.n_steps)")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                    }
                    .position(x: geometry.size.width/1.4, y: geometry.size.height/2.6)
                        
                }
                .position(x: geometry.size.width/2, y: -geometry.size.height/3.2)
                .frame(width: geometry.size.width, height: geometry.size.height/5, alignment: .center)
            }
        }
        .onAppear
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
            {
                self.managerKcal!.steps = self.healthStore.steps
                self.managerUser.steps = self.healthStore.steps
                
                n_steps = self.healthStore.steps[0].count
                
                buttonBar!.onChange(0)
            }
        }
    }
}

struct Ring_Graph: View
{
    var geometry : GeometryProxy
    @Binding var currentKcal : Float
    @Binding var totalKcal : Float
    @Binding var other_circle : Float
    
    @Binding var text :  String
    
    var body: some View
    {
        ZStack
        {
            // Complete Circle
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.black.opacity(0.10), lineWidth: 10)
                .frame(width: geometry.size.width/1.2,
                       height: geometry.size.height/2)
                .position(x: geometry.size.width/10, y: geometry.size.height/18)
            
        
            Circle()
                .trim(from: 0, to: CGFloat( self.currentKcal / self.totalKcal ) )
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .frame(width: geometry.size.width/1.2,
                       height: geometry.size.height/2)
                .position(x: geometry.size.width/10, y: geometry.size.height/18)
            
            if (self.other_circle > 0.0)
            {
                Circle()
                    .trim(from: 0, to: CGFloat(self.other_circle) )
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: geometry.size.width/1.2,
                           height: geometry.size.height/2)
                    .position(x: geometry.size.width/10, y: geometry.size.height/18)
            }
        
            Text("\(String(format: "%.1f", CGFloat( self.currentKcal / self.totalKcal ) * CGFloat(100)))%")
                .font(.system(size: 75))
                .foregroundColor(.black)
                .fontWeight(.bold)
                .frame(width: geometry.size.width/1.2,
                       height: geometry.size.height/2)
                .position(x: geometry.size.width/8, y: geometry.size.height/7.6)
                .rotationEffect(.init(degrees: 90))
            
            let actual_cal : Int = Int(self.currentKcal)
            let total_cal : Int = Int(self.totalKcal)
            
            Text("Average calories burned \(text):")
                .font(.system(size: 18))
                .foregroundColor(.black)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(width: geometry.size.width/1.2,
                       height: geometry.size.height/2)
                .position(x: geometry.size.width/8, y: geometry.size.height/3.9)
                .rotationEffect(.init(degrees: 90))
            
            Text("\(actual_cal) / \(total_cal) cal")
                .font(.system(size: 28))
                .foregroundColor(.black)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(width: geometry.size.width/1.2,
                       height: geometry.size.height/2)
                .position(x: geometry.size.width/8, y: geometry.size.height/3.2)
                .rotationEffect(.init(degrees: 90))
        }
        .position(x: geometry.size.width/1.05, y: geometry.size.height/5)
        .frame(width: geometry.size.width/2, height: geometry.size.height/4, alignment: .center)
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
    @Binding var currentKcal_normal : Float
    @Binding var currentKcal_sport : Float
    @Binding var totalKcal : Float
    @Binding var managerKcal : Manager_Kcal?
    @Binding var other_circle : Float
    @Binding var text : String
    
    var idx : Int = 0
    
    func onChange(_ tag: Int)
    {
        let ris = managerKcal!.actual_cal_day()
        
        currentKcal = ris.total_cal
        currentKcal_normal = ris.cal_day_normal
        currentKcal_sport = ris.cal_day_sport
        
        if idx == 0
        {
            totalKcal = Table_Cal_Daily.average_cal_days()
            
            self.text = "daily"
        }
        else if idx == 1
        {
            totalKcal = Table_Cal_Daily.average_cal_days()
            
            self.text = "weekly"
        }
        else
        {
            totalKcal = Table_Cal_Daily.average_cal_mounth()
            
            self.text = "monthty"
            
        }
        
        other_circle = (currentKcal/totalKcal) - 1.0
    }
}


struct Homepage_Previews: PreviewProvider
{
    @StateObject static var managerUser: ManagerUser = ManagerUser()
    @StateObject static var healthStore: HealthKitManager = HealthKitManager()
   
    @State static var managerKcal : Manager_Kcal? = Manager_Kcal()
    
    @State static var chose_period = 0
    @State static var currentKcal : Float = 0.0
    @State static var currentKcal_normal : Float = 0.0
    @State static var currentKcal_sport : Float = 0.0
    @State static var totalKcal : Float = 0.0
    @State static var other_circle : Float = 1.0
    
    @State static var text : String = "daily"
    
    
    @State static var buttonBar : ButtonBar? = ButtonBar(currentKcal: $currentKcal, currentKcal_normal: $currentKcal_normal, currentKcal_sport: $currentKcal_sport, totalKcal: $totalKcal, managerKcal: $managerKcal, other_circle: $other_circle, text: $text)
    
    static var previews: some View
    {
        Homepage(managerKcal: $managerKcal, chose_period : $chose_period, currentKcal: $currentKcal, currentKcal_normal: $currentKcal_normal, currentKcal_sport: $currentKcal_sport, totalKcal: $totalKcal, other_circle: $other_circle, text: $text, buttonBar: $buttonBar).tabItem {
            Label("Summary", systemImage: "magazine")
                        }
        .environmentObject(managerUser)
        .environmentObject(healthStore)
    }
}
 

