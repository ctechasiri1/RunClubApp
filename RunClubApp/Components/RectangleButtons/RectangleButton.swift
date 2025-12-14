//
//  RectangleButton.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import SwiftUI

struct RectangleButton: View {
    let buttonName: String
    let imageName: String
    let buttonAction: () -> Void
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            HStack {
                Text(buttonName)
                Image(systemName: imageName)
            }
            .foregroundStyle(.white)
            .font(.system(.title3, design: .default, weight: .semibold))
            .frame(width: 180, height: 60)
            .background(.primaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

#Preview {
    RectangleButton(buttonName: "Resume", imageName: "play.fill", buttonAction: {})
}
