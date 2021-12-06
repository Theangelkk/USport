//
//  USportApp.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

@main
struct USportApp: App
{
    @StateObject var UserAPP : User = User()
    @StateObject var Dict_History : IO_Dictionary_History = IO_Dictionary_History()
        
    var body: some Scene
    {
        WindowGroup
        {
            PreviewAPP()
                .environmentObject(UserAPP)
                .environmentObject(Dict_History)
        }
    }
}
