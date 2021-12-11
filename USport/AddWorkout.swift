//
//  AddWorkout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct AddWorkout: View
{
    @EnvironmentObject var managerUser : ManagerUser
    @EnvironmentObject var healthStore : HealthKitManager
    
    @State var changeView : Bool = false
    @State var nameWorkout : String = ""
    
    @State var workouts : [Workout] = [Workout]()
    
    @Binding var n_wokouts : Int
    
    var body: some View
    {
        GeometryReader
        {            
            geometry in
            
            NavigationView
            {
                Section
                {
                    List
                    {
                        ForEach(0..<managerUser.UserAPP.workouts.count, id:\.self)
                        {
                            idx in
                            
                            ButtonWorkout(workouts: $workouts, idx_workout: idx)
                        }
                    }
                }
                .navigationBarTitle("Add your workouts")
                .toolbar
                {
                    ToolbarItemGroup(placement: .navigationBarTrailing)
                    {
                        Button(action:
                        {
                            changeView = true
                            
                            managerUser.UserAPP.workouts = workouts
                            
                            UserCoreData.save_user_on_CoreData(user: managerUser.UserAPP, delete_old: true)
                            
                            for i in 0..<managerUser.UserAPP.workouts.count
                            {
                                print(managerUser.UserAPP.workouts[i].Title)
                                print(managerUser.UserAPP.workouts[i].name_day())
                            }
                            
                        })
                        {
                            Text("Done")
                        }
                    }
                }
            }
            
            if(changeView == true)
            {
                Dashboard()
                    .environmentObject(managerUser)
                    .environmentObject(healthStore)
            }
        }
        .onAppear
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
            {
                self.managerUser.steps = self.healthStore.steps
            }
            
            for _ in 0..<n_wokouts
            {
                workouts.append(Workout())
            }
        }
    }
}

struct ButtonWorkout: View
{
    @Binding var workouts : [Workout]
    
    @State var idx_workout : Int
    
    var titleButton : String = "Workout"
            
    @State private var esit : Bool = false
    
    var body: some View
    {
        NavigationLink(destination: EditWorkout(workouts: $workouts,  idx_workout: $idx_workout))
        {
            Text(workouts[idx_workout].Title)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20))
                .foregroundColor(Color.black)
        }
    }
}


struct AddWorkout_Previews: PreviewProvider
{
    @StateObject static var UserAPP : User = User(n_workout: 3)
    @State static var n_workouts : Int = 3
    
    static var previews: some View
    {
        AddWorkout(n_wokouts: $n_workouts)
            .environmentObject(self.UserAPP)
    }
}
