//
//  PreviewAPP.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI
import HealthKit

struct PreviewAPP: View
{
    @StateObject var managerUser : ManagerUser = ManagerUser()
    @StateObject var healthStore: HealthKitManager = HealthKitManager()
    
    @State private var showMainView = false
    
    @State private var angle : Double = 360
    @State private var opacity : Double = 1
    @State private var scale : CGFloat = 1
    
    @State private var firstTime : Bool = true
    
    init()
    {        
        DrawingWorkouts.register()
        
        CoreDataManager.start()
    }

    var body: some View
    {
        Group
        {
            if showMainView
            {
                if firstTime == false
                {
                    Dashboard()
                        .environmentObject(managerUser)
                        .environmentObject(healthStore)
                }
                else
                {
                    ChoseSport()
                        .environmentObject(managerUser)
                        .environmentObject(healthStore)
                }
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
            let usr : UserCoreData? = UserCoreData.get_user()
            
            /*
                Loading attempt of UserApp
             */
            if usr != nil
            {
                self.managerUser.UserAPP = User()
                
                managerUser.UserAPP.load_UserCoreData(usr: usr)
            
                self.firstTime = false
            }
            else
            {
                Table_Cal_Daily.remove_all()
                
                Table_Cal_Daily.test(n_days: 10)
            }
    
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
            {
                self.managerUser.steps = self.healthStore.steps
            }
            
            withAnimation(.linear(duration: 3))
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
