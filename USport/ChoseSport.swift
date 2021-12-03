//
//  ChoseSport.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct ChoseSport: View {
    var body: some View {
        ZStack{
            GeometryReader{ geometry in
                Image("Logo")
                .resizable()
                .aspectRatio(contentMode:.fill)
                .edgesIgnoringSafeArea([.top,.bottom])
                .blur(radius: 5)
                .opacity(0.15)
                .frame(width: geometry.size.width)
            }
            
            VStack{
                Text("Chose your sport")
                    .foregroundColor(Color.blue)
                        .font(.system(size: 37))
                        .bold()
            
                HStack{
                    ChoiceButton(ImageName: "omino_nuoto")
                    ChoiceButton(ImageName: "omino_palestra")
                }.padding()
            
                HStack{
                    ChoiceButton(ImageName: "omino_nuoto")
                    ChoiceButton(ImageName: "omino_palestra")
                }.padding()
            
                HStack{
                    ChoiceButton(ImageName: "omino_nuoto")
                    ChoiceButton(ImageName: "omino_palestra")
                }.padding()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("NEXT")
                }
            }
        }
    }
}

struct ChoseSport_Previews: PreviewProvider {
    static var previews: some View {
        ChoseSport()
    }
}
