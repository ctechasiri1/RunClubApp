//
//  SmallCircleButton.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import SwiftUI

struct SmallCircleButton: View {
    let buttonImage: String
    let buttonAction: () -> Void
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            Image(systemName: buttonImage)
                .font(.system(.title3))
                .padding(20)
                .background(.primaryBackground)
                .clipShape(Circle())
        }
    }
}

#Preview {
    SmallCircleButton(buttonImage: "arrow.down.right.and.arrow.up.left", buttonAction: { })
}
