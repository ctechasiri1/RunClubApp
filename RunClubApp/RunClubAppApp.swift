//
//  RunClubAppApp.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import SwiftUI

@main
struct RunClubAppApp: App {
    @StateObject private var locationService: MapKitManager
    private var dataService: SupabaseManager
    @StateObject private var viewModel: RunTrackerViewModel
    
    //TODO: Add some comments to understand this
    init() {
        let mapManager = MapKitManager()
        let data = SupabaseManager()
        
        self.dataService = data
        _locationService = StateObject(wrappedValue: mapManager)
        
        _viewModel = StateObject(wrappedValue: RunTrackerViewModel(locationService: mapManager, dataService: data))
    }
    
    var body: some Scene {
        WindowGroup {
            RunClubTabView()
                .environmentObject(viewModel)
        }
    }
}
