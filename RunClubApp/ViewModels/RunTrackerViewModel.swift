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
    
    private let locationService: LocationService
    private var cancellables = Set<AnyCancellable>()
    
    init(locationService: LocationService) {
        self.locationService = locationService
        addSubscriber()
    }
    
    private func addSubscriber() {
        locationService.$displayRegion
            .sink { [weak self] newDisplayRegion in
                self?.displayRegion = newDisplayRegion
            }
            .store(in: &cancellables)
    }
}

