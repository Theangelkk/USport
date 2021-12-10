//
//  ChoiceButton.swift
//  USport
//
//  Created by Alessandro Ferrara on 03/12/21.
//

import SwiftUI

struct ChoiceButton: View
{
    @Binding var sportSelected : String
    
    var nameSport : String
    var ImageName : String
    
    var geometry : GeometryProxy
    
    @State var esit : Bool = false
        
    var body: some View
    {
        Button(action: {
            sportSelected = nameSport
        })
        {
            if self.sportSelected != self.nameSport
            {
                Image(ImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rectangle())
                    .border(Color.black)
                    .overlay(
                        Text(nameSport)
                            .font(.system(size: 20))
                            .position(x: geometry.size.width/6, y: geometry.size.height/5.4)
                            .foregroundColor(.black)
                    )
            }
            else
            {
                Image(ImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rectangle())
                    .border(Color.blue, width: 4.0)
                    .overlay(
                        Text(nameSport)
                            .font(.system(size: 20))
                            .position(x: geometry.size.width/6, y: geometry.size.height/5.4)
                            .foregroundColor(.blue)
                    )
            }
                
        }
        
        
    }
}

struct ChoiceButton_Activity: View
{
    @Binding var sportSelected : String
    
    var nameSport : String
    var ImageName : String
    
    var geometry : GeometryProxy
    
    @State var esit : Bool = false
        
    var body: some View
    {
        Button(action: {
            sportSelected = nameSport
        })
        {
            if self.sportSelected != self.nameSport
            {
                Image(ImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rectangle())
                    .border(Color.black)
                    .overlay(
                        Text(nameSport)
                            .font(.system(size: 20))
                            .position(x: geometry.size.width/6, y: geometry.size.height/5.4)
                            .foregroundColor(.black)
                    )
            }
            else
            {
                Image(ImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rectangle())
                    .border(Color.blue, width: 4.0)
                    .overlay(
                        Text(nameSport)
                            .font(.system(size: 20))
                            .position(x: geometry.size.width/6, y: geometry.size.height/5.4)
                            .foregroundColor(.blue)
                    )
            }
                
        }
        
        
    }
}

struct ButtonNext: View
{
    @Binding var changeView : Bool
    
    var body: some View {
        Button(action: {changeView = true})
        {
            Text("Next")
                .font(.system(size: 15))
                .fontWeight(.heavy)
                
        }
        .buttonStyle(CustomButtonStyle())
    }
}

/*
    Custom Design "Next" Button
 */
struct CustomButtonStyle: ButtonStyle
{
    private struct CustomButtonStyleView<V: View>: View
    {
        @State private var isOverButton = false

        let content: () -> V

        var body: some View
        {
            ZStack {
                content()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(50)
            }
            .padding(3)
            .onHover
            {
                over in
                self.isOverButton = over
                
            }
            .overlay(
                VStack
                     {
                         if self.isOverButton
                         {
                             Rectangle()
                                 .stroke(Color.blue, lineWidth: 2)
                         } else
                         {
                             EmptyView()
                         }
                     })
            }
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        CustomButtonStyleView { configuration.label }
    }
}
