//
//  CountdownView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import SwiftUI

struct CountdownView: View {
    @StateObject private var countdownViewModel = CountdownViewModel()
    @ObservedObject private var liveRunViewModel = LiveRunViewModel()
    
    var onFinished: () -> Void
    
    var body: some View {
        Text("\(countdownViewModel.countdown)")
            .foregroundStyle(.white)
            .contentTransition(.numericText())
            .font(.system(size: 250, weight: .bold))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryBackground)
            .onAppear {
                countdownViewModel.startCountdownTimer()
                liveRunViewModel.resetRun()
                countdownViewModel.onTimerFinished = onFinished
            }
    }
}

#Preview {
    CountdownView {
        print("✅ Countdown finished in preview!")
    }
}
