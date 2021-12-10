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
    @EnvironmentObject var managerUser : ManagerUser
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
        
        Table_Cal_Daily.remove_all()
        
        Table_Cal_Daily.test(n_days: 10)
        
        var items : [Table_Cal_Daily] = Table_Cal_Daily.get_all_items()
        
        for i in 0..<items.count
        {
            print("Day \(i)")
            print("Date: \(items[i].date)")
            print("Name of Day: \(items[i].name_day)")
            print("Cal Daily: \(items[i].cal_daily)")
            print("Cal Sport: \(items[i].cal_sport)")
        }
        
        print("avg day = \(Table_Cal_Daily.average_cal_days())")
        print("avg week = \(Table_Cal_Daily.average_cal_week())")
        
        print("Number of elements: \(items.count)")
        
    }

    var body: some View
    {
        Group
        {
            if showMainView
            {
                if firstTime == false
                {
                    Homepage()
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
            
            //self.attendi()
        
        }
    }
    
    func attendi()
    {
        while healthStore.isLoading == false
        {
            print(healthStore.steps.count)
        }
    }
}

struct PreviewAPP_Previews: PreviewProvider {
    static var previews: some View
    {
        PreviewAPP()
    }
}
