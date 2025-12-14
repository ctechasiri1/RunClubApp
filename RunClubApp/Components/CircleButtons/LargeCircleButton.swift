//
//  LargeCircleButton.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import SwiftUI

struct LargeCircleButton: View {
    let workoutIsPaused: Bool
    var buttonAction: () -> Void
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            Image(systemName: workoutIsPaused ? "play.fill" : "pause.fill")
                .font(.system(.largeTitle))
                .padding(36)
                .background(.primaryBackground)
                .clipShape(Circle())
        }
        .scaleEffect(workoutIsPaused ? 1.0 : 0.9)
        .animation(.bouncy, value: workoutIsPaused)
    }
}

#Preview {
    LargeCircleButton(workoutIsPaused: true, buttonAction: { })
}
