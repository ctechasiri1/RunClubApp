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
            
            TimeSection(liveRunViewModel: liveRunViewModel)
                .padding(.bottom, 10)
            
            DistanceSection(liveRunViewModel: liveRunViewModel)
            
            Spacer()
            
            HStack(spacing: 30) {
                AvgPaceSection(liveRunViewModel: liveRunViewModel)
                HeartRateSection()
            }
            .padding(.bottom, 80)
            .frame(maxWidth: .infinity, alignment: .center)

            HStack(spacing: 20) {
                ResetButton(liveRunViewModel: liveRunViewModel)
                PauseButton(liveRunViewModel: liveRunViewModel, homeViewModel: homeViewModel)
                ExitButton(liveRunViewModel: liveRunViewModel, homeViewModel: homeViewModel)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 80)
            .foregroundStyle(.white)
            
            Spacer()
        }
        .onAppear {
            liveRunViewModel.resumeRun()
        }
    }
}

#Preview {
    WorkoutView(liveRunViewModel: LiveRunViewModel(), homeViewModel: HomeViewModel())
}

// MARK:
private struct TimeSection: View {
    @ObservedObject var liveRunViewModel: LiveRunViewModel
    
    var body: some View {
        VStack {
            Text(liveRunViewModel.elapsedTime.converToTimerFormat())
                .font(.system(size: 65, weight: .regular, design: .monospaced))
                
            Text("TIME")
                .foregroundStyle(.gray)
        }
    }
}

// MARK:
private struct DistanceSection: View {
    @ObservedObject var liveRunViewModel: LiveRunViewModel
    
    var body: some View {
        VStack {
            Text(liveRunViewModel.distance.convertToMile())
                .font(.system(size: 120, weight: .bold, design: .default))
            
            Text("MILES")
                .foregroundStyle(.gray)
        }
    }
}

// MARK:
private struct AvgPaceSection: View {
    @ObservedObject var liveRunViewModel: LiveRunViewModel
    
    var body: some View {
        VStack {
            Text(liveRunViewModel.pace)
                .font(.system(size: 35, weight: .regular))
            
            Text("AVG PACE")
                .foregroundStyle(.gray)
        }
    }
}

// MARK:
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

// MARK:
private struct PauseButton: View {
    @ObservedObject var liveRunViewModel: LiveRunViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        Button {
            liveRunViewModel.pauseRun()
            liveRunViewModel.workoutIsPaused = true
            homeViewModel.activeScreenCover = .pauseWorkout
        } label: {
            Image(systemName: liveRunViewModel.workoutIsPaused ? "play.fill" : "pause.fill")
                .font(.system(.largeTitle))
                .padding(36)
                .background(.primaryBackground)
                .clipShape(Circle())
        }
        .scaleEffect(liveRunViewModel.workoutIsPaused ? 1.0 : 0.9)
        .animation(.bouncy, value: liveRunViewModel.workoutIsPaused)
    }
}

// MARK:
private struct ResetButton: View {
    @ObservedObject var liveRunViewModel: LiveRunViewModel
    
    var body: some View {
        Button {
            liveRunViewModel.resetRun()
        } label: {
            Image(systemName: "square.fill")
                .font(.system(.title3))
                .padding(20)
                .background(.primaryBackground)
                .clipShape(Circle())
        }
    }
}

// MARK:
private struct ExitButton: View {
    @ObservedObject var liveRunViewModel: LiveRunViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        Button {
            liveRunViewModel.resetRun()
            homeViewModel.activeScreenCover = nil
        } label: {
            Image(systemName: "arrow.down.right.and.arrow.up.left")
                .font(.system(.title3))
                .padding(20)
                .background(.primaryBackground)
                .clipShape(Circle())
        }
    }
}

