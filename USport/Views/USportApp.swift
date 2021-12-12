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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene
    {
        WindowGroup
        {
            PreviewAPP()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        DrawingWorkouts.register()
        
        return true
    }
}
