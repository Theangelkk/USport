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
    var body: some View {
        ZStack{
            GeometryReader{
                geometry in
                
                NavigationView{
                    
                    VStack{
                        Spacer()
                        
                    HStack{
                        
                        Image("grafico")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .position(x:90, y:76)
                        
                        Button(action:{
                            //profile
                        }){
                        Label("", systemImage: "person.crop.circle")
                            .font(.title)
                            .foregroundColor(Color.black)
                        }
                    }
                        
                        HStack{
                            Button(action: {
                                
                            }, label: {
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
                            })
                            
                            Button(action: {
                                
                            }, label: {
                                Rectangle()
                                    .cornerRadius(30)
                                    .foregroundColor(Color.red)
                                    .overlay(
                                        Text("History")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .buttonStyle(.borderedProminent)
                                    .controlSize(.large)
                                    )
                            })
                            
                        }.padding()
                        
                        HStack{
                
                            Button(action: {
                                
                            }, label: {
                                Rectangle()
                                    .cornerRadius(30)
                                    .foregroundColor(Color.green)
                                    .overlay(
                                        Text("Add new activity")
                                    .font(.headline)
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
                                        Text("Advices")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .buttonStyle(.borderedProminent)
                                    .controlSize(.large)
                                    )
                            })

                        }.padding()
                        
                        Text("USport")
                            .foregroundColor(Color.blue)
                                .font(.system(size: 37))
                                .bold()
                                .position(x: geometry.size.width/2, y: 20)
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
