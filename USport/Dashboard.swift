//
//  Dashboard.swift
//  USport
//
//  Created by Alessandro Ferrara on 09/12/21.
//

import SwiftUI

struct Dashboard: View
{
    @EnvironmentObject var managerUser : ManagerUser
    @EnvironmentObject var healthStore : HealthKitManager
    
    @State var managerKcal : Manager_Kcal? = nil
    
    @State var chose_period = 0
    @State var currentKcal : Float = 0.0
    @State var totalKcal : Float = 0.0
    
    @State var buttonBar : ButtonBar? = nil
    
    var body: some View
    {
        TabView {
                            
            Homepage(managerKcal: $managerKcal, chose_period : $chose_period, currentKcal: $currentKcal, totalKcal: $totalKcal, buttonBar: $buttonBar).tabItem {
                Label("Homepage", systemImage: "magazine")
                            }
            .environmentObject(managerUser)
            .environmentObject(healthStore)
                                        
            ChoseActivity().tabItem {
                Rectangle()
                    .cornerRadius(30)
                    .foregroundColor(Color.green)
                    .overlay(
                            
                        Label("Add new activity", systemImage: "plus.circle")
                            .font(.system(size: 32))
                            .foregroundColor(Color.white)
                            .buttonStyle(.borderedProminent)
                                .controlSize(.large)
                                                )
                                        }

            History().tabItem {
                Rectangle()
                    .cornerRadius(30)
                    .foregroundColor(Color.red)
                    .overlay(
                        
                        Label("History", systemImage: "list.bullet")
                            .font(.system(size: 38))
                            .foregroundColor(Color.white)
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large))
                                        }
                            
            Profile().tabItem {
                Image(systemName: "person.circle")
                Text("Profile")
            }
        }.onAppear
        {
            self.managerKcal = Manager_Kcal()
            self.managerKcal!.user = self.managerUser.UserAPP
            self.managerKcal!.steps = self.managerUser.steps
            
            self.buttonBar = ButtonBar(currentKcal: $currentKcal, totalKcal: $totalKcal, managerKcal: $managerKcal)
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    
    static var previews: some View {
        Dashboard()
    }
}
