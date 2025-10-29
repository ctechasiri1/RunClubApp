//
//  HomeView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var liveRunViewModel: LiveRunViewModel
    
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
                    titleSection
                }
                ToolbarItem(placement: .topBarTrailing) {
                    logoutButton
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    HomeView(homeViewModel: HomeViewModel(), liveRunViewModel: LiveRunViewModel())
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
        .frame(width: 160, height: 80, alignment: .center)
        .padding()
    }
    
    private var mapSection: some View {
        Map(position: $liveRunViewModel.displayRegion) {
            UserAnnotation()
        }
    }
    
    private var startButton: some View {
        Button {
            homeViewModel.startRunFlow()
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
    
    private var logoutButton: some View {
        Button {
            Task {
                try await SupabaseAuthManager.shared.logout()
            }
        } label: {
            Text("Logout")
                .foregroundStyle(.red)
                .clipShape(Capsule())
        }

    }
}
