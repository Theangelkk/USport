//
//  InsertData.swift
//  USport
//
//  Created by Angelo Casolaro on 03/12/21.
//

import SwiftUI

struct InsertData: View {
    @State var nickname: String = ""
    @State var weight: String = ""
    @State var height: String = ""
    @State var number_workout: String = ""
    var body: some View{
        VStack{
            NavigationView{
                Form{
                    TextField("Nickname",text: $nickname)
                    TextField("Height",text: $height)
                    TextField("Weight", text: $weight)
                    TextField("Number of Workout", text: $number_workout)
                }
                .navigationBarTitle("Insert your data")
                
               
            }
            Button(action: {}) {
                Text("Next")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 50.0)
            }
            .border(.blue)
        }
        
    }
}

struct InsertData_Previews: PreviewProvider {
    static var previews: some View {
        InsertData()
            
    }
}
