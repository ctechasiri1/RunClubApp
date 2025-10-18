//
//  HomeView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject private var viewModel: RunTrackerViewModel
    @EnvironmentObject private var locationService: LocationService
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .bottom) {
                    mapSection
                    
                    startButton
                }
                .ignoresSafeArea()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 20) {
                        Text("Run")
                            .font(.system(.title2, weight: .bold))
                            .foregroundStyle(.primaryBackground)
                        
                        Image(systemName: "figure.run")
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .frame(width: 120, height: 60, alignment: .leading)
                    .background(.black.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.top, 40)
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(RunTrackerViewModel(locationService: LocationService()))
}

extension HomeView {
    private var mapSection: some View {
        Map(position: $viewModel.displayRegion)
    }
    
    private var startButton: some View {
        Button {
            /// insert start timer
        } label: {
            Text("Start")
                .foregroundStyle(.black)
                .font(.system(.title2, weight: .bold))
        }
        .frame(width: 80, height: 80)
        .background(.primaryBackground)
        .clipShape(Circle())
        .padding(.bottom, 40)
    }
}
