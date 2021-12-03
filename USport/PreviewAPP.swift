//
//  PreviewAPP.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct PreviewAPP: View {
    
    @State private var showMainView = false
    
    // Variabili per le animazioni
    @State private var angle : Double = 360
    @State private var opacity : Double = 1
    @State private var scale : CGFloat = 1
    
    var body: some View
    {
        Group
        {
            if showMainView
            {
                ContentView()
            }
            else
            {
                ZStack
                {
                    Image("Logo")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .rotation3DEffect(.degrees(angle),
                                          axis: (x: 0.0, y: 1.0, z: 0.0))
                        .opacity(opacity)
                        .scaleEffect(scale)
                }
            }
        }
        .onAppear
        {
            withAnimation(.linear(duration: 2))
            {
                angle = 0
                scale = 3
                opacity = 0
            }
            
            withAnimation(.linear.delay(1.75))
            {
                showMainView = true
            }
        }
    }
}

struct PreviewAPP_Previews: PreviewProvider {
    static var previews: some View
    {
        PreviewAPP()
    }
}
