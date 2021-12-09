//
//  USportApp.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI
import HealthKit

@main
struct USportApp: App
{
    @StateObject var managerUser : ManagerUser = ManagerUser()
    
    var body: some Scene
    {
        WindowGroup
        {
            PreviewAPP()
                .environmentObject(managerUser)
        }
    }
}
