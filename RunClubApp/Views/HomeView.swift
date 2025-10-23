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
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .bottom) {
                    mapSection
                    
                    startButton
                }
                .ignoresSafeArea()
            }
            .fullScreenCover(isPresented: $viewModel.presentFullScreenCover, content: {
                FullScreenCoverContainerView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    titleSection
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(RunTrackerViewModel(locationService: MapKitManager(), dataService: SupabaseManager()))
}

extension HomeView {
    private var titleSection: some View {
        HStack(spacing: 20) {
            Text("Let's Run")
                .font(.system(.title2, weight: .bold))
                .foregroundStyle(.primaryBackground)
            
            Image(systemName: "figure.run")
                .foregroundStyle(.secondaryBackground)
        }
        .padding()
        .frame(width: 180, height: 60, alignment: .leading)
        .background(.white.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.top, 40)
    }
    
    private var mapSection: some View {
        Map(position: $viewModel.displayRegion) {
            UserAnnotation()
        }
    }
    
    private var startButton: some View {
        Button {
            viewModel.presentFullScreenCover = true
            viewModel.currentFullScreenCover = .countdown
        } label: {
            Text("Start")
                .foregroundStyle(.white)
                .font(.system(.title2, weight: .bold))
        }
        .frame(width: 80, height: 80)
        .background(.primaryBackground)
        .clipShape(Circle())
        .padding(.bottom, 140)
        .shadow(color: .primaryBackground, radius: 10)
    }
}
