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

    
    @State private var showMainView = false
    
    // Variabili per le animazioni
    @State private var angle : Double = 360
    @State private var opacity : Double = 1
    @State private var scale : CGFloat = 1
    
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    
    let typesToRead: Set<HKObjectType> = [.activitySummaryType(), .workoutType(), .correlationType(forIdentifier: .food)!]

    let typesToWrite: Set<HKSampleType> = [.correlationType(forIdentifier: .food)!, .quantityType(forIdentifier: .activeEnergyBurned)!]
        
    init()
    {
        self.healthStore = HealthStore()
        
        DrawingWorkouts.register()
        
        CoreDataManager.start()
        
        Table_Cal_Daily.remove_all()
        
        Table_Cal_Daily.test(n_days: 10)
        
        /*
        var items : [Table_Cal_Daily] = Table_Cal_Daily.get_all_items()
        
        for i in 0..<items.count
        {
            print("Day \(i)")
            print("Date: \(items[i].date)")
            print("Name of Day: \(items[i].name_day)")
            print("Cal Daily: \(items[i].cal_daily)")
            print("Cal Sport: \(items[i].cal_sport)")
        }
        
        print("first day = \(Table_Cal_Daily.get_first_date())")
        
        print("avg day = \(Table_Cal_Daily.average_cal_days())")
        print("avg week = \(Table_Cal_Daily.average_cal_week())")
        
        print("Number of elements: \(items.count)")
         */
    }
    
    var body: some View
    {
        Group
        {
            if showMainView
            {
                if managerUser.UserAPP.nickname != "Default"
                {
                    Homepage()
                        .environmentObject(managerUser)
                }
                else
                {
                    ChoseSport()
                        .environmentObject(managerUser)
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
            self.enableHealth()
            self.load()
            
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
    
    func enableHealth()
    {
        if let healthStore = healthStore
        {
            healthStore.requestAuthorization
            {
                success in
                if success
                {
                    healthStore.calculateSteps
                    {
                        statisticsCollection in
                        if let statisticsCollection = statisticsCollection
                        {
                            self.healthStore!.updateUIFromStatistics(statisticsCollection, n_days_prev: 0, end: Date())
                        }
                    }
                }
            }
        }
    }
    
    // BUG FATALE
    func load()
    {
        let usr : UserCoreData? = UserCoreData.get_user()
        
        /*
            Loading attempt of UserApp
         */
        if usr != nil
        {
            self.managerUser.UserAPP = User()
            
            managerUser.UserAPP.load_UserCoreData(usr: usr)
        }
    }
}

struct PreviewAPP_Previews: PreviewProvider {
    static var previews: some View
    {
        PreviewAPP()
    }
}
