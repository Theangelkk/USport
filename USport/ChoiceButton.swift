//
//  ChoiceButton.swift
//  USport
//
//  Created by Alessandro Ferrara on 03/12/21.
//

import SwiftUI

struct ChoiceButton: View {
    var ImageName : String

    var body: some View {
        Button(action: {}) {
            Image(ImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Rectangle())
                .border(.black)
        }.shadow(color: Color.black, radius: 6, x: 10, y: 10)
    }
}
