//
//  WorkoutView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/18/25.
//

import SwiftUI

struct WorkoutView: View {
    @EnvironmentObject private var viewModel: RunTrackerViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            timeSection
                .padding(.bottom, 10)
            
            distanceSection
            
            Spacer()
            
            HStack(spacing: 30) {
                avgPaceSection
                heartRateSection
            }
            .padding(.bottom, 80)
            .frame(maxWidth: .infinity, alignment: .center)

            HStack(spacing: 20) {
                resetButton
                pauseButton
                exitButton
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 80)
            .foregroundStyle(.white)
            
            
            Spacer()
        }
        .fullScreenCover(isPresented: $viewModel.presentPauseWorkout, content: {
            PauseWorkoutView()
        })
        .onAppear {
            viewModel.resetRun()
            viewModel.resumeRun()
            viewModel.startWorkoutTimer()
            viewModel.workoutIsPaused = false
        }
    }
}

#Preview {
    WorkoutView()
        .environmentObject(RunTrackerViewModel(locationService: LocationService()))
}

extension WorkoutView {
    private var timeSection: some View {
        VStack {
            Text(viewModel.converToTimerFormat(from: viewModel.elapsedTime))
                .font(.system(size: 65, weight: .regular, design: .monospaced))
                
            Text("TIME")
                .foregroundStyle(.gray)
        }
    }
    
    private var distanceSection: some View {
        VStack {
            Text(viewModel.convertToMile(from: viewModel.distance))
                .font(.system(size: 120, weight: .bold, design: .default))
            
            Text("MILES")
                .foregroundStyle(.gray)
        }
    }
    
    private var avgPaceSection: some View {
        VStack {
            Text(viewModel.pace)
                .font(.system(size: 35, weight: .regular))
            
            Text("AVG PACE")
                .foregroundStyle(.gray)
        }
    }
    
    private var heartRateSection: some View {
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
    
    private var pauseButton: some View {
        Button {
            viewModel.presentPauseWorkout = true
            viewModel.stopTimer()
            viewModel.pauseRun()
        } label: {
            Image(systemName: viewModel.workoutIsPaused ? "play.fill" : "pause.fill")
                .font(.system(.largeTitle))
                .padding(36)
                .background(.primaryBackground)
                .clipShape(Circle())
        }
        .scaleEffect(viewModel.workoutIsPaused ? 1.0 : 0.9)
        .animation(.bouncy, value: viewModel.workoutIsPaused)
    }
    
    private var resetButton: some View {
        Button {
            viewModel.resetRun()
        } label: {
            Image(systemName: "square.fill")
                .font(.system(.title3))
                .padding(20)
                .background(.primaryBackground)
                .clipShape(Circle())
        }
    }
    
    private var exitButton: some View {
        Button {
            viewModel.exitRun()
            viewModel.resetRun()
        } label: {
            Image(systemName: "arrow.down.right.and.arrow.up.left")
                .font(.system(.title3))
                .padding(20)
                .background(.primaryBackground)
                .clipShape(Circle())
        }
    }
}
