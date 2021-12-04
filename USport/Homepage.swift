//
//  Homepage.swift
//  USport
//
//  Created by Alessandro Ferrara on 04/12/21.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
        ZStack{
            GeometryReader{
                geometry in
                
                VStack{
                    Spacer()
                    
                    HStack{
                        
                    }.padding()
                    
                    HStack{
                        
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

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
