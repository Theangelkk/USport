//
//  AddWorkout.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct AddWorkout: View
{
    @EnvironmentObject var UserAPP : User
    
    @State var changeView : Bool = false
    
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
                        ButtonWorkout(titleButton: "1")
                        ButtonWorkout(titleButton: "2")
                    }
                }
                .navigationBarTitle("Add your workouts")
            }
            
            ButtonNext(changeView: $changeView)
                .position(x: geometry.size.width/2, y: (geometry.size.height)-60)
        }
    }
}

struct AddWorkout_Previews: PreviewProvider {
    
    static var previews: some View
    {
        AddWorkout()
            .environmentObject(User())
    }
}

struct ButtonWorkout: View
{
    var titleButton : String
    
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/)
        {
            Text(self.titleButton)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20))
                .foregroundColor(Color.black)
        }
    }
}
