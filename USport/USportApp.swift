//
//  USportApp.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

@main
struct USportApp: App {
    
    @StateObject var UserAPP : User = User()
        
    var body: some Scene
    {
        WindowGroup
        {
            PreviewAPP()
                .environmentObject(UserAPP)
        }
    }
}
