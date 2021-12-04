//
//  ChoseSport.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct ChoseSport: View {
        
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
                    
                    Text("Chose your sport")
                        .foregroundColor(Color.blue)
                            .font(.system(size: 37))
                            .bold()
                            .position(x: geometry.size.width/2, y: 20)
                    
                    Group{
                        HStack{
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Football", ImageName: "omino_nuoto")
                            
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Volleyball", ImageName: "omino_palestra")
                            
                        }.padding()
                    
                        HStack{
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Basket", ImageName: "omino_nuoto")
                            
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Tennis", ImageName: "omino_palestra")
                        }.padding()
                    
                        HStack{
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Tennis", ImageName: "omino_nuoto")
                            
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Volleyball", ImageName: "omino_palestra")
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


struct ChoseSport_Previews: PreviewProvider
{
    static var previews: some View
    {
        ChoseSport()
    }
}

