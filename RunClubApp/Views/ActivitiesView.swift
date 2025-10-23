//
//  ActivitiesView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/18/25.
//

import SwiftUI

struct ActivitiesView: View {
    @EnvironmentObject private var viewModel: RunTrackerViewModel
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.runs, id: \.id) { run in
                Text(run.title)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchRunData()
            }
        }
    }
}

#Preview {
    ActivitiesView()
        .environmentObject(RunTrackerViewModel(locationService: MapKitManager(), dataService: SupabaseManager()))
}
