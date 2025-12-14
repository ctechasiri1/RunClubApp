//
//  PauseWorkoutView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/18/25.
//

import SwiftUI
import _MapKit_SwiftUI

struct PauseWorkoutView: View {
    @ObservedObject var liveRunViewModel: LiveRunViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            BackgroundMap(startPosition: $liveRunViewModel.displayRegion, coordinates: liveRunViewModel.locationList)
            
            Spacer()
            
            VStack {
                CardTitle(title: $liveRunViewModel.runTitle)
                
                Divider()
                    .frame(width: 350)
                
                CardRunStats(distance: liveRunViewModel.distance.convertToMile(), time: liveRunViewModel.elapsedTime.converToTimerFormatPauseWorkout(), pace: liveRunViewModel.pace)
                
                CardTechnicalStats(heartRate: "N/A", caloriesBurned: "N/A", elevationGain: liveRunViewModel.elevation.convertToFeet())
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .offset(y: -60)
            
            HStack(spacing: 20) {
                RectangleButton(buttonName: "Resume", imageName: "play.fill") {
                    homeViewModel.activeScreenCover = .workout
                    liveRunViewModel.workoutIsPaused = false
                }

                RectangleButton(buttonName: "Finish", imageName: "square.circle") {
                    Task {
                        try await liveRunViewModel.saveRunData()
                        liveRunViewModel.workoutIsPaused = false
                        liveRunViewModel.stopTimer()
                        liveRunViewModel.resetRun()
                        homeViewModel.activeScreenCover = nil
                    }
                }
            }
            .offset(y: -20)
        }
    }
}

#Preview {
    PauseWorkoutView(liveRunViewModel: LiveRunViewModel(), homeViewModel: HomeViewModel())
}

private struct BackgroundMap: View {
    @Binding var startPosition: MapCameraPosition
    let coordinates: [CLLocationCoordinate2D]
    
    var body: some View {
        Map(position: $startPosition) {
            if let startCoordinate = coordinates.first,
               let endCoordinate = coordinates.last {
                Marker("Start", coordinate: startCoordinate)
                    .tint(.primaryBackground)
                
                Marker("Finish", coordinate: endCoordinate)
                    .tint(.primaryBackground)
            }

            MapPolyline(coordinates: coordinates)
                .stroke(.primaryBackground, lineWidth: 5)
        }
        .ignoresSafeArea()
    }
}


private struct CardTitle: View {
    @Binding var title: String
    
    var body: some View {
        HStack {
            TextField("Enter Title", text: $title)
                .font(.system(.largeTitle, design: .default, weight: .bold))
                .foregroundStyle(.secondaryBackground)
                .padding([.top, .leading, .trailing])
        }
        .padding()
    }
}

private struct CardRunStats: View {
    let distance: String
    let time: String
    let pace: String
    
    var body: some View {
        HStack {
            
            RunStatView(stat: distance, statTitle: "MILES")
            
            Divider()
                .frame(height: 30)
            
            RunStatView(stat: time, statTitle: "TIME")
            
            Divider()
                .frame(height: 30)
            
            RunStatView(stat: pace, statTitle: "PACE")
        }
        .padding([.leading, .trailing, .top])
    }
}

private struct CardTechnicalStats: View {
    let heartRate: String
    let caloriesBurned: String
    let elevationGain: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Technical Metric")
                .font(.system(.title3, design: .default, weight: .bold))
            
            Divider()
                .frame(width: 350)
            
            TechnicalMetricView(metericImage: "heart.fill", metricName: "Average Heart Rate", metricValue: heartRate, metricUnit: "BPM", color: Color.pink)
            
            Divider()
                .frame(width: 350)
            
            TechnicalMetricView(metericImage: "bolt.fill", metricName: "Total Calories Burned", metricValue: caloriesBurned, metricUnit: "kCal", color: Color.yellow)
            
            Divider()
                .frame(width: 350)
            
            TechnicalMetricView(metericImage: "line.diagonal.arrow", metricName: "Elevation Gain", metricValue: elevationGain, metricUnit: "ft", color: Color.green)
            
        }
        .frame(alignment: .leading)
        .padding()
    }
}
