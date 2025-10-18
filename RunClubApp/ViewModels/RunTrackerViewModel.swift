//
//  RunTrackerViewModel.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import Combine
import _MapKit_SwiftUI
import Foundation

class RunTrackerViewModel: ObservableObject {
    @Published var displayRegion: MapCameraPosition = .region(MKCoordinateRegion())
    @Published var presentCountdown: Bool = false
    @Published var countdown: Int = 3
    @Published var selectedTab: Tab = .home
    
    private let locationService: LocationService
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    
    init(locationService: LocationService) {
        self.locationService = locationService
        addSubscriber()
    }
    
    //TODO: add some comments to understand this
    private func addSubscriber() {
        locationService.$displayRegion
            .sink { [weak self] newDisplayRegion in
                self?.displayRegion = newDisplayRegion
            }
            .store(in: &cancellables)
    }
    
    func timerCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                self.timer?.invalidate()
                self.presentCountdown = false
            }
        })
    }
}

