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
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                List(viewModel.runs) { run in
                    VStack {
                        if let runDate = run.createdAt {
                            titleSection(title: run.title, date: runDate)
                        }

                        if let runID = run.id,
                           let startLocation = viewModel.locationList[runID]?.first,
                           let locations = viewModel.locationList[runID] {
                            let startRegion = MKCoordinateRegion(
                                center: startLocation,
                                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                            
                            mapSection(startRegion: startRegion, locations: locations)
                        }
                        
                        HStack(spacing: 50) {
                            timeSection(time: run.elpasedTime)
                            
                            paceSection(pace: run.pace)
                            
                            elevationSection(elevation: "105")
                        }
                    }
                }
            }
        }
        .task {
            if let userID = SupabaseAuthManager.shared.currentSession?.user.id {
                await viewModel.fetchRunData(for: userID)
            }
            viewModel.fetchLocationData()
        }
    }
}

#Preview {
    ActivitiesView()
}

extension ActivitiesView {
    private func titleSection(title: String, date: Date) -> some View {
        HStack {
            Image(systemName: "person")
                .font(.system(.largeTitle, weight: .bold))
                .foregroundStyle(.primaryBackground)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(.title2))
                Text(viewModel.iso8601Formatter(for: date))
                    .font(.system(.subheadline))
                    .foregroundStyle(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func mapSection(startRegion: MKCoordinateRegion, locations: [CLLocationCoordinate2D]) -> some View {
        Map(initialPosition: .region(startRegion)) {
            MapPolyline(coordinates: locations)
                .stroke(.primaryBackground, lineWidth: 5)
        }
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    private func timeSection(time: String) -> some View {
        VStack {
            Text(time)
                .font(.system(.headline))
            Text("TIME")
                .font(.system(.subheadline))
                .foregroundStyle(.gray)
        }
    }
    
    private func paceSection(pace: String) -> some View {
        VStack {
            Text(pace)
                .font(.system(.headline))
                .foregroundStyle(.primaryBackground)
            Text("PACE")
                .font(.system(.subheadline))
                .foregroundStyle(.gray)
        }
    }
    
    private func elevationSection(elevation: String) -> some View {
        VStack {
            Text(elevation)
                .font(.system(.headline))
            Text("ELEV. (FT)")
                .font(.system(.subheadline))
                .foregroundStyle(.gray)
        }
    }
}
