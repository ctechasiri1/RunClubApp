//
//  FullScreenCoverContainerView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/22/25.
//

import SwiftUI

enum FullScreenCoverState {
    case countdown, workout, pauseworkout
}

struct FullScreenCoverContainerView: View {
    @EnvironmentObject private var viewModel: RunTrackerViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.currentFullScreenCover {
            case .countdown:
                CountdownView()
                    .onAppear {
                        viewModel.startCountdownTimer()
                    }
            case .workout:
                WorkoutView()
            case .pauseworkout:
                PauseWorkoutView()
            }
        }
    }
}

#Preview {
    FullScreenCoverContainerView()
        .environmentObject(RunTrackerViewModel(locationService: MapKitManager(), dataService: SupabaseManager()))
}
