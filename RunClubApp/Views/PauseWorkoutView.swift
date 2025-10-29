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
            backgroundMap
            
            Spacer()
            
            VStack {
                cardTitle
                
                Divider()
                    .frame(width: 350)
                
                HStack {
                    
                    mileMetric
                    
                    Divider()
                        .frame(height: 30)
                    
                    timeMetric
                    
                    Divider()
                        .frame(height: 30)
                    
                    paceMetric
                }
                .padding([.leading, .trailing, .top])
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    technicalMetricTitle
                    
                    Divider()
                        .frame(width: 350)
                    
                    heartRateMetric
                    
                    Divider()
                        .frame(width: 350)
                    
                    calorieMetric
                    
                    Divider()
                        .frame(width: 350)
                    
                    elevationMetric
                    
                }
                .frame(alignment: .leading)
                .padding()
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .offset(y: -60)
            
            HStack(spacing: 20) {
                resumeButton
                finishButton
            }
            .offset(y: -20)
        }
    }
}

#Preview {
    PauseWorkoutView(liveRunViewModel: LiveRunViewModel(), homeViewModel: HomeViewModel())
}

extension PauseWorkoutView {
    private var cardTitle: some View {
        HStack {
            TextField("Enter Title", text: $liveRunViewModel.runTitle)
                .font(.system(.largeTitle, design: .default, weight: .bold))
                .foregroundStyle(.secondaryBackground)
                .padding([.top, .leading, .trailing])
        }
        .padding()
    }
    
    private var mileMetric: some View {
        VStack {
            Text(liveRunViewModel.convertToMile(from: liveRunViewModel.distance))
                .font(.system(.title, design: .default, weight: .bold))
                .foregroundStyle(.primaryBackground)
            
            Text("MILES")
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var timeMetric: some View {
        VStack {
            Text(liveRunViewModel.converToTimerFormat(from: liveRunViewModel.elapsedTime))
                .font(.system(.title2, design: .default, weight: .bold))
            
            Text("TIME")
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var paceMetric: some View {
        VStack {
            Text(liveRunViewModel.pace)
                .font(.system(.title2, design: .default, weight: .bold))
            
            Text("PACE")
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var technicalMetricTitle: some View {
        Text("Technical Metric")
            .font(.system(.title3, design: .default, weight: .bold))
    }
    
    private var heartRateMetric: some View {
        HStack {
            Image(systemName: "heart.fill")
                .foregroundStyle(.pink.opacity(0.6))
            
            Text("Average Heart Rate")
            
            Spacer()
            
            Text(String(format: "%.1f", liveRunViewModel.heartRate))
                .font(.system(.title3, design: .default, weight: .bold))
            
            Text("BPM")
                .foregroundStyle(.gray)
        }
        .padding(8)
    }
    
    private var calorieMetric: some View {
        
        HStack {
            Image(systemName: "bolt.fill")
                .foregroundStyle(.yellow.opacity(0.6))
            
            Text("Total Calories Burned")
            
            Spacer()
            
            Text("159")
                .font(.system(.title3, design: .default, weight: .bold))
            
            Text("kCal")
                .foregroundStyle(.gray)
        }
        .padding(8)
    }
    
    private var elevationMetric: some View {
        HStack {
            Image(systemName: "line.diagonal.arrow")
                .foregroundStyle(.green.opacity(0.6))
            
            Text("Elevation Gain")
            
            Spacer()
            
            Text("56")
                .font(.system(.title3, design: .default, weight: .bold))
            
            Text("ft")
                .foregroundStyle(.gray)
        }
        .padding(8)
    }
    
    private var backgroundMap: some View {
        Map(position: $liveRunViewModel.displayRegion) {
            MapPolyline(coordinates: liveRunViewModel.locationList)
                .stroke(.primaryBackground, lineWidth: 5)
        }
        .ignoresSafeArea()
    }
    
    private var resumeButton: some View {
        Button {
            homeViewModel.activeScreenCover = .workout
            liveRunViewModel.workoutIsPaused = false
        } label: {
            HStack {
                Text("Resume")
                Image(systemName: "play.fill")
            }
            .foregroundStyle(.white)
            .font(.system(.title3, design: .default, weight: .semibold))
            .frame(width: 180, height: 60)
            .background(.primaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
    
    private var finishButton: some View {
        Button {
            Task {
                try await liveRunViewModel.saveRunData()
                liveRunViewModel.workoutIsPaused = false
                liveRunViewModel.stopTimer()
                liveRunViewModel.resetRun()
                homeViewModel.activeScreenCover = nil
            }
        } label: {
            HStack {
                Text("Finish")
                Image(systemName: "square.circle")
            }
            .foregroundStyle(.white)
            .font(.system(.title3, design: .default, weight: .semibold))
            .frame(width: 180, height: 60)
            .background(.primaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}
