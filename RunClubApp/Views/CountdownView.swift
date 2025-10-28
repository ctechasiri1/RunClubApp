//
//  CountdownView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import SwiftUI

struct CountdownView: View {
    @StateObject private var viewModel = CountdownViewModel()
    var onFinished: () -> Void
    
    var body: some View {
        Text("\(viewModel.countdown)")
            .foregroundStyle(.white)
            .contentTransition(.numericText())
            .font(.system(size: 250, weight: .bold))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryBackground)
            .onAppear {
                viewModel.startCountdownTimer()
                viewModel.onTimerFinished = onFinished
            }
    }
}

#Preview {
    CountdownView {
        print("✅ Countdown finished in preview!")
    }
}
