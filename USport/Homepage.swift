//
//  Homepage.swift
//  USport
//
//  Created by Alessandro Ferrara on 04/12/21.
//


//fare struct per prendersi il giorno in modo dinamico al posto di calendario
//fare struct specifiche per i vari button
//fare segmented Picker per i primi tre tasti sopra
//fare la navigation view
//migliorare l'interfaccia
//grafico


import SwiftUI

struct Homepage: View {
    
    @State var chose_period = 0
    var currentKcal : CGFloat = 1200.0
    var totalKcal : CGFloat = 2500.0
    
    var body: some View {
        ZStack{
            GeometryReader{
                geometry in
                
                NavigationView{
                    
                    VStack{
                        Spacer()
                        
                        Picker("which period do you want to evaluate", selection: $chose_period) {
                            Button(action:{
                                
                            }){
                                        Text("Monthly").tag(0)
                            }
                            
                            Button(action: {
                                
                            }){
                                        Text("Daily").tag(1)
                            }
                            
                            Button(action: {
                                
                            }){
                                Text("Weekly").tag(2)
                            }
                        }.pickerStyle(.segmented)
                            .position(x: 195, y: 3)
                        
                        
                    HStack{
                        
                        Ring_Graph(geometry: geometry, currentKcal: currentKcal, totalKcal: totalKcal)
                        
                        NavigationLink(destination: Profile())
                        {
                            Image("profile_icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/4, height: geometry.size.height/10)
                                    .position(x: geometry.size.width/3, y: geometry.size.height/20)
                            
                        }
                    }
                        
                        HStack{
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
                            
                            NavigationLink(destination: History())
                            {
                                Rectangle()
                                    .cornerRadius(30)
                                    .foregroundColor(Color.red)
                                    .overlay(
                                        Label("History", systemImage: "list.bullet")
                                            
                                    .font(.system(size: 30))
                                    .foregroundColor(Color.white)
                                    .buttonStyle(.borderedProminent)
                                    .controlSize(.large))
                                    
                                    
                                    
                            }
                            
                        }.padding()
                        
                        HStack{
                
                            Button(action: {
                                
                            }, label: {
                                Rectangle()
                                    .cornerRadius(30)
                                    .foregroundColor(Color.green)
                                    .overlay(
                                        Label("Add new activity", systemImage: "plus.circle")
                                            .font(.system(size: 30))
                                    .foregroundColor(Color.white)
                                    .buttonStyle(.borderedProminent)
                                    .controlSize(.large)
                                    )
                            })
                            
                            Button(action: {
                                
                            }, label: {
                                Rectangle()
                                    .cornerRadius(30)
                                    .foregroundColor(Color.cyan)
                                    .overlay(
                                        Label("Advices", systemImage: "lasso.and.sparkles")
                                            .font(.system(size: 30))
                                        .foregroundColor(Color.white)
                                    .buttonStyle(.borderedProminent)
                                    .controlSize(.large)
                                    )
                            })

                        }.padding()
                        
                        Text("USport")
                            .foregroundColor(Color.blue)
                                .font(.system(size: 70))
                                .bold()
                                .position(x: geometry.size.width/2, y: 90)
                        
                    }
                }
            }
        }
    }
}


struct ButtonHome_page: View{
    var name_button : String
    
    var body: some View {
        Text(" ")
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}

struct Ring_Graph: View
{
    var geometry : GeometryProxy
    
    var currentKcal : CGFloat = 1200.0
    var totalKcal : CGFloat = 2500.0
    
    var target_perc : CGFloat = 0.0
    @State var actual_perc : CGFloat = 0.0
    
    var target_to_circle : CGFloat = 0.0
    @State var actual_to_cirle : CGFloat = 0.0
    
    init(geometry : GeometryProxy, currentKcal : CGFloat, totalKcal : CGFloat)
    {
        self.geometry = geometry
        self.currentKcal = currentKcal
        self.totalKcal = totalKcal
        
        self.target_perc = CGFloat( self.currentKcal / self.totalKcal ) * CGFloat(100)
        
        self.target_to_circle = CGFloat(self.currentKcal / self.totalKcal)
    }
    
    func animation_circle() -> String
    {
        if(self.actual_to_cirle < self.target_to_circle)
        {
            self.actual_to_cirle += 0.01
        }
        
        if(self.actual_perc < self.target_perc)
        {
            self.actual_perc += 0.01
        }
        
        return ""
    }
        
    var body: some View
    {
        ZStack
        {
            // Complete Circle
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.black.opacity(0.10), lineWidth: 10)
                .frame(width: geometry.size.width/1.7,
                       height: geometry.size.height/3.5)
                .position(x: geometry.size.width/3, y: geometry.size.height/7)
        
            Circle()
                .trim(from: 0, to: self.target_to_circle)
                .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .frame(width: geometry.size.width/1.7,
                       height: geometry.size.height/3.5)
                .position(x: geometry.size.width/3, y: geometry.size.height/7)
            
            
            Text("\( String(format: "%.1f", self.target_perc))%")
                .font(.system(size: 50))
                .foregroundColor(.black)
                .fontWeight(.bold)
                .position(x: geometry.size.width/3, y: geometry.size.height/50)
                .rotationEffect(.init(degrees: 90))
        }
        .rotationEffect(.init(degrees: -90))
        .shadow(color: Color.black.opacity(0.10), radius: 30, x: 10, y: 10)
    }
    
    func getPercent(Current : CGFloat, Goal : CGFloat) -> String
    {
        let per = CGFloat( Current / Goal) * 100
        
        return String(format: "%.1f", per)
    }

}

