//
//  History.swift
//  USport
//
//  Created by Alessandro Ferrara on 04/12/21.
//

import SwiftUI
import SwiftUICharts

struct History: View {

    let data : [Double] = [12,22,6,1,2,18]
    
    var body: some View
    {
        GeometryReader
        {
            geometry in
            
            Spacer()
            
            Section
            {
                LineView(data: data)
                    .padding()
                    .position(x: geometry.size.width/2, y: geometry.size.height/2.1)
            
            }
            
            Section
            {
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.blue, lineWidth: 3)
                .frame(width: geometry.size.width - 30, height: geometry.size.height/2.2)
                .position(x: geometry.size.width/2, y: geometry.size.height/1.4)
                
                Image("life_person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/2.8, height: geometry.size.height/3.4)
                    .position(x: geometry.size.width/3.2, y: geometry.size.height/1.65)
                
                Text("10000 Kcal")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 38))
                    .frame(width: geometry.size.width/3, height: 100)
                    .position(x: geometry.size.width/1.5, y: geometry.size.height/1.60)
                
        
                Text("15000 Kcal")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 38))
                    .frame(width: geometry.size.width/3, height: 100)
                    .position(x: geometry.size.width/1.5, y: geometry.size.height/1.18)
                
                Image("life_person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/2.8, height: geometry.size.height/3.4)
                    .position(x: geometry.size.width/3.2, y: geometry.size.height/1.20)
               
                
            }
        }
        .navigationBarTitle("History", displayMode: .inline)
        
        .navigationBarItems(trailing: NavigationLink(destination: History_Filter()
        ){
                Image(systemName: "calendar")
        })
    }
    
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
