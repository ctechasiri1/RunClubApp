//
//  ActivitiesView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/18/25.
//

import MapKit
import SwiftUI

struct ActivitiesView: View {
    @StateObject private var viewModel = ActivitiesViewModel()
    @State var displayRegion: MapCameraPosition = .region(MKCoordinateRegion())
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    List(viewModel.runs) { run in
                        VStack {
                            if let runDate = run.createdAt {
                                CardHeader(title: run.title, date: runDate.iso8601Formatter())
                            }
                            
                            if let runID = run.id,
                               let start = viewModel.locationList[runID]?.first,
                               let end = viewModel.locationList[runID]?.last,
                               let coordinates = viewModel.locationList[runID] {
                                CardMap(startCoordinate: start, endCoordinate: end, coordinates: coordinates)
                            }
                            
                            CardStats(time: run.elpasedTime, pace: run.pace, elevation: run.elevationGain.convertToFeet())
                        }
                    }
                }
            }
            .navigationTitle("Activities")
            .task {
                if let userID = SupabaseAuthManager.shared.currentSession?.user.id {
                    await viewModel.fetchRunData(for: userID)
                }
            }
        }
    }
}

#Preview {
    ActivitiesView()
}

private struct CardHeader: View {
    let title: String
    let date: String
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .font(.system(.title3, weight: .bold))
                .foregroundStyle(.primaryBackground)
            
            Text(title)
                .font(.system(.title2, weight: .bold))
            
            Spacer()
            
            Text(date)
                .font(.system(.caption))
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
    }
}

private struct CardMap: View {
    let startCoordinate: CLLocationCoordinate2D
    let endCoordinate: CLLocationCoordinate2D
    let coordinates: [CLLocationCoordinate2D]
    
    var body: some View {
        Map {
            Marker("Start", coordinate: startCoordinate)
            Marker("End", coordinate: endCoordinate)
                
            MapPolyline(coordinates: coordinates)
                .stroke(.primaryBackground, lineWidth: 5)
                
        }
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

private struct CardStats: View {
    let time: String
    let pace: String
    let elevation: String
    
    var body: some View {
        HStack(spacing: 50) {
            VStack {
                Text("TIME")
                    .font(.system(.subheadline))
                    .foregroundStyle(.gray)
                
                Text(time)
                    .font(.system(.headline))

            }
            VStack {
                Text("PACE")
                    .font(.system(.subheadline))
                    .foregroundStyle(.gray)
                
                Text(pace)
                    .font(.system(.headline))
                    .foregroundStyle(.primaryBackground)
            }
            
            VStack {
                Text("ELEV. (FT)")
                    .font(.system(.subheadline))
                    .foregroundStyle(.gray)
                Text(elevation)
                    .font(.system(.headline))
            }
        }
    }
}
