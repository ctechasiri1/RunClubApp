//
//  HomeViewModel.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/27/25.
//

import Foundation

enum ActiveCover: Identifiable {
    case countdown, workout, pauseWorkout
    
    var id: Self { self }
}

class HomeViewModel: ObservableObject {
    @Published var activeScreenCover: ActiveCover?
    
    func startRunFlow() {
        activeScreenCover = .countdown
    }
    
    func transitionToWorkout() {
        activeScreenCover = .workout
    }
    
    func transitionToPauseWorkout() {
        activeScreenCover = .pauseWorkout
    }
    
    func dismissFullScreenCover() {
        activeScreenCover = nil
    }
}
