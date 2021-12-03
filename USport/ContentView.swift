//
//  ContentView.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct ContentView: View
{
    @EnvironmentObject var UserAPP : User
    
    var body: some View {
        Text("Ciao sono Raffaele!!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
