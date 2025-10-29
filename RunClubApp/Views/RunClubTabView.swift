//
//  RunClubTabView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import SwiftUI

struct RunClubTabView: View {
    @StateObject private var countdownViewModel = CountdownViewModel()
    @StateObject private var liveRunViewModel = LiveRunViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        if loginViewModel.validSession {
            ZStack(alignment: .bottom) {
                TabView {
                    HomeView(homeViewModel: homeViewModel, liveRunViewModel: liveRunViewModel)
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    
                    ActivitiesView()
                        .tabItem {
                            Label("Activities", systemImage: "figure.run")
                        }
                }
                .tint(.primaryBackground)
            }
            .fullScreenCover(item: $homeViewModel.activeScreenCover) { cover in
                switch cover {
                case .countdown:
                    CountdownView {
                        liveRunViewModel.startWorkoutTimer()
                        homeViewModel.transitionToWorkout()
                    }
                case .workout:
                    WorkoutView(liveRunViewModel: liveRunViewModel, homeViewModel: homeViewModel)
                case .pauseWorkout:
                    PauseWorkoutView(liveRunViewModel: liveRunViewModel, homeViewModel: homeViewModel)
                }
            }
        } else {
            LoginView(viewModel: loginViewModel)
        }
    }
}

#Preview {
    RunClubTabView()
}
