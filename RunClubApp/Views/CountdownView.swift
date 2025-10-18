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
            .font(.system(size: 250, weight: .bold))
            .animation(.smooth, value: viewModel.countdown)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryBackground)
            .onAppear {
                viewModel.timerCountdown()
            }
    }
}

#Preview {
    CountdownView()
        .environmentObject(RunTrackerViewModel(locationService: LocationService()))
}
