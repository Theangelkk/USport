//
//  ChoseActivity.swift
//  USport
//
//  Created by Alessandro Ferrara on 06/12/21.
//

import SwiftUI
import Foundation

struct ChoseActivity: View {
    
    @State var sportSelected : String = "Default"
    @State var changeView : Bool = false
    
    var body: some View {
        ZStack
        {
            GeometryReader{
                
                geometry in
                
                Image("Logo")
                .resizable()
                .aspectRatio(contentMode:.fill)
                .edgesIgnoringSafeArea([.top,.bottom])
                .blur(radius: 5)
                .opacity(0.15)
                .frame(width: geometry.size.width)
                    
                
                VStack
                {
                    Spacer()
                   
                    HStack{
                    
                    NavigationLink(destination: Homepage().navigationBarBackButtonHidden(true)){
                                   Text("< Back")
                            .foregroundColor(Color.cyan)
                            .bold()
                            .position(x: geometry.size.width/11, y: 20)
                    }
                    
                    
                    Text("Chose activity")
                        .foregroundColor(Color.blue)
                        .font(.system(size: 37))
                            .bold()
                            .position(x: geometry.size.width/45, y:18)
                    }
                                
                    Group{
                        HStack{
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Volleyball", ImageName: "omino_pallavolo")
                            
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Tennis", ImageName: "omino_tennis")
                            
                        }.padding()
                    
                        HStack{
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Swim", ImageName: "omino_swim1")
                            
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Gym", ImageName: "omino_gym")
                        }.padding()
                    
                        HStack{
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Football", ImageName: "omino_calcio")
                            
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Basket", ImageName: "omino_basket")
                        }.padding()
                    }
                    .position(x: geometry.size.width/2, y: -50)
                    
                }
                
                ButtonNext(changeView: $changeView)
                    .position(x: geometry.size.width/2, y: (geometry.size.height)-60)
                
                
                if(changeView == true)
                {
                    InsertData(nameSport : $sportSelected)
                }
            }
        }
    }
}


struct ChoseActivity_Previews: PreviewProvider
{
    static var previews: some View
    {
        ChoseActivity()
    }
}
