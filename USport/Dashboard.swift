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
    
    @State var other_circle : Float = 1.0

    @State var text : String = "daily"
    
    @State var managerKcal : Manager_Kcal? = nil
    
    @State var chose_period = 0
    @State var currentKcal : Float = 0.0
    @State var totalKcal : Float = 0.0
    
    @State var buttonBar : ButtonBar? = nil
    
    var body: some View
    {
        TabView {
                            
            Homepage(managerKcal: $managerKcal, chose_period : $chose_period, currentKcal: $currentKcal, totalKcal: $totalKcal, other_circle: $other_circle, text: $text, buttonBar: $buttonBar).tabItem {
                Label("Summary", systemImage: "magazine")
                            }
            .environmentObject(managerUser)
            .environmentObject(healthStore)
                                        
            ChoseActivity().tabItem {
                Rectangle()
                    .cornerRadius(30)
                    .foregroundColor(Color.green)
                    .overlay(
                            
                        Label("Activities", systemImage: "plus.circle")
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
            
            self.buttonBar =
            ButtonBar(currentKcal: $currentKcal, totalKcal: $totalKcal, managerKcal: $managerKcal, other_circle: $other_circle, text: $text)
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    
    static var previews: some View {
        Dashboard()
    }
}
