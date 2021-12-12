//
//  ChoseSport.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct ChoseSport: View
{
    @EnvironmentObject var managerUser : ManagerUser
    @EnvironmentObject var healthStore : HealthKitManager
    
    @State var sportSelected : String = "Default"
    @State var changeView : Bool = false
    
    var body: some View
    {
        ZStack
        {
            GeometryReader
            {
                
                geometry in
            
                VStack
                {
                    Spacer()
                    
                    Text("Chose your sport")
                        .foregroundColor(Color.blue)
                            .font(.system(size: 37))
                            .bold()
                            .position(x: geometry.size.width/2, y: geometry.size.height/35)
                    Group
                    {
                        HStack
                        {
                            ChoiceButton(changeView: $changeView,sportSelected: $sportSelected, nameSport: "Volleyball", ImageName: "omino_pallavolo", geometry : geometry)
                            
                            ChoiceButton(changeView: $changeView,sportSelected: $sportSelected, nameSport: "Tennis", ImageName: "omino_tennis", geometry : geometry)
                            
                        }.padding()
                    
                        HStack
                        {
                            ChoiceButton(changeView: $changeView,sportSelected: $sportSelected, nameSport: "Swim", ImageName: "omino_swim1", geometry : geometry)
                            
                            ChoiceButton(changeView: $changeView,sportSelected: $sportSelected, nameSport: "Gym", ImageName: "omino_gym", geometry : geometry)
                            
                        }.padding()
                    
                        HStack
                        {
                            ChoiceButton(changeView: $changeView,sportSelected: $sportSelected, nameSport: "Football", ImageName: "omino_calcio", geometry : geometry)
                            
                            ChoiceButton(changeView: $changeView,sportSelected: $sportSelected, nameSport: "Basket", ImageName: "omino_basket", geometry : geometry)
                            
                        }.padding()
                    }
                    .position(x: geometry.size.width/2, y: -geometry.size.height/25)
                    
                }
                
                if(changeView == true)
                {
                    InsertData(nameSport : $sportSelected)
                        .environmentObject(managerUser)
                        .environmentObject(healthStore)
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
