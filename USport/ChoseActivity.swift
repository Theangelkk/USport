//
//  ChoseActivity.swift
//  USport
//
//  Created by Alessandro Ferrara on 06/12/21.
//

import SwiftUI
import Foundation

struct ChoseActivity: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var sportSelected : String = "Default"

    var body: some View {
        
        ZStack
        {
            // Mettere un immagine di sfondo
            
            GeometryReader
            {

                geometry in
                
                VStack
                {
                    Group{
                        HStack{
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Volleyball", ImageName: "omino_pallavolo", geometry : geometry)
                            
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Tennis", ImageName: "omino_tennis", geometry : geometry)
                            
                        }.padding()
                    
                        HStack{
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Swim", ImageName: "omino_swim1", geometry : geometry)
                            
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Gym", ImageName: "omino_gym", geometry : geometry)
                        }.padding()
                    
                        HStack{
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Football", ImageName: "omino_calcio", geometry : geometry)
                            
                            ChoiceButton(sportSelected: $sportSelected, nameSport: "Basket", ImageName: "omino_basket", geometry : geometry)
                        }.padding()
                    }
                    .position(x: geometry.size.width/2, y:  geometry.size.height/6)
                    .frame(width: geometry.size.width, height: geometry.size.height/4)
                }
                
                Button(action:
                {
                    self.presentationMode.wrappedValue.dismiss()
                })
                {
                    Text("Next")
                        .font(.system(size: 25))
                        .fontWeight(.heavy)
                }
                .buttonStyle(CustomButtonStyle())
                .position(x: geometry.size.width/2, y: (geometry.size.height)-60)
                
            }
            .navigationBarTitle("Chose your activity", displayMode: .inline)
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

