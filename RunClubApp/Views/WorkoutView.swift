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
        .onAppear {
            liveRunViewModel.resumeRun()
            liveRunViewModel.resetRun()
        }
    }
}

#Preview {
    WorkoutView(liveRunViewModel: LiveRunViewModel(), homeViewModel: HomeViewModel())
}

extension WorkoutView {
    private var timeSection: some View {
        VStack {
            Text(liveRunViewModel.converToTimerFormat(from: liveRunViewModel.elapsedTime))
                .font(.system(size: 65, weight: .regular, design: .monospaced))
                
            Text("TIME")
                .foregroundStyle(.gray)
        }
    }
    
    private var distanceSection: some View {
        VStack {
            Text(liveRunViewModel.convertToMile(from: liveRunViewModel.distance))
                .font(.system(size: 120, weight: .bold, design: .default))
            
            Text("MILES")
                .foregroundStyle(.gray)
        }
    }
    
    private var avgPaceSection: some View {
        VStack {
            Text(liveRunViewModel.pace)
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
    
    private var resetButton: some View {
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
    
    private var exitButton: some View {
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
