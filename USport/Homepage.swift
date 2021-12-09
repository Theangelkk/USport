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
    
    @State var managerKcal : Manager_Kcal? = nil
    
    @State var chose_period = 0
    @State var currentKcal : Float = 0.0
    @State var totalKcal : Float = 0.0
    
    var names_button_bar : [String] = ["Daily", "Weekly", "Monthty"]
    
    var buttonBar : ButtonBar = ButtonBar()
        
    var body: some View
    {
        ZStack
        {
            // Mettere un immagine di sfondo
            
            GeometryReader
            {
                geometry in
                
                NavigationView
                {
                    VStack{
                        Spacer()
                        
                        Text("USport")
                            .foregroundColor(Color.blue)
                                .font(.system(size: 50))
                                .bold()
                                .position(x: geometry.size.width/2, y: -geometry.size.height/12)
                                .shadow(color: Color.black.opacity(0.40), radius: 5, x: 5, y: 10)
                        
                        Picker("Which period do you want to evaluate", selection: $chose_period)
                        {
                            ForEach(0..<self.names_button_bar.count)
                            {
                                i in
                                Text(self.names_button_bar[i])
                            }
                                    
                        }
                        .onChange(of: self.chose_period, perform:
                                    { (value) in
                            buttonBar.onChange(value, homepage: self)
                                    })
                        .onAppear { buttonBar.onChange(0, homepage: self) }
                        
                        .pickerStyle(.segmented)
                            .position(x: geometry.size.width/2.1, y: -geometry.size.height/4.5)
                            .frame(width: geometry.size.width - 15, height: geometry.size.height/90)
                            .shadow(color: Color.black.opacity(0.40), radius: 5, x: 5, y: 10)
                            
                        Ring_Graph(geometry: geometry, currentKcal: $currentKcal, totalKcal: $totalKcal)
                            .shadow(color: Color.black.opacity(0.30), radius: 5, x: 5, y: 10)
                        
                        HStack
                        {
                            NavigationLink(destination: History())
                            {
                                Rectangle()
                                    .cornerRadius(30)
                                    .foregroundColor(Color.blue)
                                    .overlay(
                                        Text("Calendario")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .buttonStyle(.borderedProminent)
                                    .controlSize(.large)
                                    )
                            }
                            .shadow(color: Color.black.opacity(0.40), radius: 5, x: 5, y: 10)
                            
                            NavigationLink(destination: History()
                                            .environmentObject(managerUser))
                            {
                                Rectangle()
                                    .cornerRadius(30)
                                    .foregroundColor(Color.red)
                                    .overlay(
                                        Label("History", systemImage: "list.bullet")
                                            
                                    .font(.system(size: 38))
                                    .foregroundColor(Color.white)
                                    .buttonStyle(.borderedProminent)
                                    .controlSize(.large))
                            }
                            .shadow(color: Color.black.opacity(0.40), radius: 5, x: 5, y: 10)
                            
                        }.padding()
                        
                        HStack
                        {
                            NavigationLink(destination: ChoseActivity().environmentObject(managerUser))
                            {
                                Rectangle()
                                    .cornerRadius(30)
                                    .foregroundColor(Color.green)
                                    .overlay(
                                        Label("Add new activity", systemImage: "plus.circle")
                                            .font(.system(size: 32))
                                    .foregroundColor(Color.white)
                                    .buttonStyle(.borderedProminent)
                                    .controlSize(.large)
                                    )
                            }
                            .shadow(color: Color.black.opacity(0.40), radius: 5, x: 5, y: 10)
                            
                            NavigationLink(destination:
                                            Profile().environmentObject(managerUser)
                            )
                            {
                                Image("profile_icon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width/3, height: geometry.size.height/1)
                                        .position(x: geometry.size.width/4.3, y: geometry.size.height/12)
                            }
                            .shadow(color: Color.black.opacity(0.40), radius: 5, x: 5, y: 10)

                        }.padding()
                    }
                }
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
                .frame(width: geometry.size.width/1.5,
                       height: geometry.size.height)
                .position(x: geometry.size.width/1.5, y: geometry.size.height/10.5)
        
            Circle()
                .trim(from: 0, to: CGFloat( self.currentKcal.wrappedValue / self.totalKcal.wrappedValue ) )
                .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .frame(width: geometry.size.width/1.5,
                       height: geometry.size.height)
                .position(x: geometry.size.width/1.5, y: geometry.size.height/10.5)
            
            
            Text("\(String(format: "%.1f", CGFloat( self.currentKcal.wrappedValue / self.totalKcal.wrappedValue ) * CGFloat(100)))%")
                .font(.system(size: 65))
                .foregroundColor(.black)
                .fontWeight(.bold)
                .position(x: geometry.size.width/2, y: -geometry.size.height/30)
                .rotationEffect(.init(degrees: 90))
            
            let actual_cal : Int = Int(self.currentKcal.wrappedValue)
            let total_cal : Int = Int(self.totalKcal.wrappedValue)
            
            Text("\(actual_cal) / \(total_cal) cal")
                .font(.system(size: 24))
                .foregroundColor(.black)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .position(x: geometry.size.width/2.05, y: geometry.size.height/13)
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

class ButtonBar
{
    var homepage : Homepage? = nil
    var idx : Int = 0

    init()
    {
        self.homepage = nil
    }
    
    func onChange(_ tag: Int, homepage : Homepage)
    {
        self.homepage = homepage
        self.homepage!.managerKcal = Manager_Kcal(user: homepage.managerUser.UserAPP)
        
        self.homepage!.currentKcal = self.homepage!.managerKcal!.actual_cal_day(user : self.homepage!.managerUser.UserAPP)
        
        self.homepage!.totalKcal = Table_Cal_Daily.average_cal_days()
    }
}

struct Homepage_Previews: PreviewProvider
{
    @StateObject static var UserAPP : User = User(n_workout: 3)
    
    static var previews: some View
    {
        Homepage()
            .environmentObject(UserAPP)
    }
}

