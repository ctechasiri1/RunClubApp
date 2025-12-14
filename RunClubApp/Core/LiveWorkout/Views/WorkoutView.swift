//
//  WorkoutView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/18/25.
//

import SwiftUI

struct WorkoutView: View {
    @ObservedObject var liveRunViewModel: LiveRunViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            TimeSection(time: liveRunViewModel.elapsedTime.converToTimerFormat())
                .padding(.bottom, 10)
            
            DistanceSection(distance: liveRunViewModel.distance.convertToMile())
            
            Spacer()
            
            HStack(spacing: 30) {
                AvgPaceSection(pace: liveRunViewModel.pace)
                HeartRateSection()
            }
            .padding(.bottom, 80)
            .frame(maxWidth: .infinity, alignment: .center)

            HStack(spacing: 20) {
                SmallCircleButton(buttonImage: "square.fill") {
                    liveRunViewModel.resetRun()
                    liveRunViewModel.resumeRun()
                }
                
                LargeCircleButton(workoutIsPaused: liveRunViewModel.workoutIsPaused) {
                    liveRunViewModel.pauseRun()
                    liveRunViewModel.workoutIsPaused = true
                    homeViewModel.activeScreenCover = .pauseWorkout
                }
                
                SmallCircleButton(buttonImage: "arrow.down.right.and.arrow.up.left") {
                    liveRunViewModel.resetRun()
                    homeViewModel.activeScreenCover = nil
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 80)
            .foregroundStyle(.white)
            
            Spacer()
        }
        .onAppear {
            liveRunViewModel.resetRun()
            liveRunViewModel.resumeRun()
        }
    }
}

#Preview {
    WorkoutView(liveRunViewModel: LiveRunViewModel(), homeViewModel: HomeViewModel())
}

private struct TimeSection: View {
    let time: String
    
    var body: some View {
        VStack {
            Text(time)
                .font(.system(size: 65, weight: .regular, design: .monospaced))
                
            Text("TIME")
                .foregroundStyle(.gray)
        }
    }
}

private struct DistanceSection: View {
    let distance: String
    
    var body: some View {
        VStack {
            Text(distance)
                .font(.system(size: 120, weight: .bold, design: .default))
            
            Text("MILES")
                .foregroundStyle(.gray)
        }
    }
}

private struct AvgPaceSection: View {
    let pace: String
    
    var body: some View {
        VStack {
            Text(pace)
                .font(.system(size: 35, weight: .regular))
            
            Text("AVG PACE")
                .foregroundStyle(.gray)
        }
    }
}

private struct HeartRateSection: View {
    var body: some View {
        VStack {
            HStack {
                Text("145")
                    .font(.system(size: 35, weight: .regular))
                
                Text("BPM")
                    .foregroundStyle(.gray)
                    .font(.system(size: 25, weight: .regular))
            }
            
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red.opacity(0.4))
                
                Text("HEART RATE")
                    .foregroundStyle(.gray)
            }
        }
    }
}
