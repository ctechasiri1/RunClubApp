//
//  CountdownView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import SwiftUI

struct CountdownView: View {
    @EnvironmentObject private var viewModel: RunTrackerViewModel
    
    var body: some View {
        Text("\(viewModel.countdown)")
            .foregroundStyle(.white)
            .contentTransition(.numericText())
            .font(.system(size: 250, weight: .bold))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryBackground)
            .fullScreenCover(isPresented: $viewModel.presentWorkout) {
                WorkoutView()
            }
    }
}

#Preview {
    CountdownView()
        .environmentObject(RunTrackerViewModel(locationService: LocationService()))
}
