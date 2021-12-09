//
//  History.swift
//  USport
//
//  Created by Alessandro Ferrara on 04/12/21.
//

import SwiftUI
import SwiftUICharts

struct History: View {

    @State var items_days : [Double] = [Double]()
    @State var Kcal_Daily : String = "--"
    @State var Kcal_Sport : String = "--"
    
    var body: some View
    {
        // Mettere un immagine di sfondo
        
        GeometryReader
        {
            geometry in
            
            Spacer()
            
            Section
            {
                LineView(data: items_days)
                    .padding()
                    .position(x: geometry.size.width/2, y: geometry.size.height/2.1)
            
            }
            
            Section
            {
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.blue, lineWidth: 3)
                    .frame(width: geometry.size.width - 30, height: geometry.size.height/2.2)
                    .position(x: geometry.size.width/2, y: geometry.size.height/1.4)
                
                Image("omino_pallavolo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/2.8, height: geometry.size.height/3.4)
                    .position(x: geometry.size.width/3.2, y: geometry.size.height/1.65)
                
                Text("\(self.Kcal_Sport) Kcal")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 36))
                    .frame(width: geometry.size.width/3, height: 100)
                    .position(x: geometry.size.width/1.5, y: geometry.size.height/1.60)
                    .shadow(color: Color.black.opacity(0.40), radius: 5, x: 5, y: 10)
                
                Text("\(self.Kcal_Daily) Kcal")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 36))
                    .frame(width: geometry.size.width/3, height: 100)
                    .position(x: geometry.size.width/1.5, y: geometry.size.height/1.18)
                    .shadow(color: Color.black.opacity(0.40), radius: 5, x: 5, y: 10)
                
                Image("life_person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/2.8, height: geometry.size.height/3.4)
                    .position(x: geometry.size.width/3.2, y: geometry.size.height/1.20)

            }
        }
        .navigationBarTitle("History", displayMode: .inline)
        
        .navigationBarItems(trailing: NavigationLink(destination: History_Filter(items_days: $items_days, Kcal_Daily: self.$Kcal_Daily, Kcal_Sport: self.$Kcal_Sport)
        ){
                Image(systemName: "calendar")
        })
    }
    
}

struct History_Previews: PreviewProvider
{
    static var previews: some View
    {
        History()
    }
}
