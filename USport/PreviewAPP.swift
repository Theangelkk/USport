//
//  PreviewAPP.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct PreviewAPP: View
{
    @State private var showMainView = false
    
    // Variabili per le animazioni
    @State private var angle : Double = 360
    @State private var opacity : Double = 1
    @State private var scale : CGFloat = 1
        
    init()
    {
        DrawingWorkouts.register()
        
        CoreDataManager.start()
        
        let usr : UserCoreData? = UserCoreData.get_user()
        
        if usr != nil
        {
            USportApp.UserAPP = User()
            
            USportApp.UserAPP!.nickname = String(usr!.nickname!)
            USportApp.UserAPP!.Age = Int(usr!.age)
            USportApp.UserAPP!.gender = usr!.gender!
            USportApp.UserAPP!.height = Int(usr!.height)
            USportApp.UserAPP!.weight = usr!.weight
            USportApp.UserAPP!.Type_of_Sport = usr!.type_of_sport!
            USportApp.UserAPP!.Type_Activity = usr!.type_of_activity!
            USportApp.UserAPP!.workouts = usr!.workouts!.workouts
        }
        
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
                if USportApp.UserAPP != nil
                {
                    Homepage()
                }
                else
                {
                    ChoseSport()
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
