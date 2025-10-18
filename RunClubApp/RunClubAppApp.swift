//
//  RunClubAppApp.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import SwiftUI

@main
struct RunClubAppApp: App {
    @StateObject private var locationService: LocationService
    @StateObject private var viewModel: RunTrackerViewModel
    
    //TODO: Add some comments to understand this
    init() {
        let service = LocationService()
        
        _locationService = StateObject(wrappedValue: service)
        _viewModel = StateObject(wrappedValue: RunTrackerViewModel(locationService: service))
    }
    
    var body: some Scene {
        WindowGroup {
            RunClubTabView()
                .environmentObject(viewModel)
        }
    }
}
