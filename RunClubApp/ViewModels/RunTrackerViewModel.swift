//
//  RunTrackerViewModel.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import AudioToolbox
import Combine
import _MapKit_SwiftUI
import Foundation

class RunTrackerViewModel: ObservableObject {
    /// for rendering the coorindates in map
    @Published var displayRegion: MapCameraPosition = .region(MKCoordinateRegion())
    
    /// for the 'HomeView'
    @Published var selectedTab: Tab = .home
    @Published var presentFullScreenCover: Bool = false
    @Published var currentFullScreenCover: FullScreenCoverState = .countdown
    
    /// for the 'CountdownView'
    @Published var countdown: Int = 3
    
    /// for the 'WorkoutView'
    @Published var pace: String = "00:00"
    @Published var distance: Double = 0.0
    @Published var elapsedTime: Double = 0.0
    @Published var workoutIsPaused: Bool = false
    
    /// for the 'PauseWorkoutView'
    @Published var runTitle: String = ""
    @Published var locationList: [CLLocationCoordinate2D] = []
    
    /// for the "ActivitiesView'
    @Published var runs: [Run] = []
    
    private let mileMultipler = 0.000621371
    private let locationService: MapKitManager
    private let dataService: SupabaseManager
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    
    init(locationService: MapKitManager, dataService: SupabaseManager) {
        self.locationService = locationService
        self.dataService = dataService
        addSubscriber()
        Task {
            await fetchRunData()
        }
    }
    
    //TODO: add some comments to understand this
    private func addSubscriber() {
        locationService.$displayRegion
            .sink { [weak self] newDisplayRegion in
                self?.displayRegion = newDisplayRegion
            }
            .store(in: &cancellables)
        
        locationService.$distanceCovered
            .sink { [weak self] newDistance in
                self?.distance = newDistance
            }
            .store(in: &cancellables)
        
        locationService.$locationList
            .sink { [weak self] newLocationList in
                self?.locationList = newLocationList
            }
            .store(in: &cancellables)
    }
    
    /// this converts 'distance' (recorded in meters) to the formatted miles
    func convertToMile(from distance : Double) -> String {
        let distanceInMile = (distance * mileMultipler)
        return String(format: "%.2f", distanceInMile)
    }
    
    /// this converts 'elpasedTime' (recorded in seconds) to the foramtted time
    func converToTimerFormat(from seconds: Double) -> String {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: seconds) ?? "00:00:00"
    }
    
    /// this converts 'pace' (recorded in seconds) to the formatted time
    func convertToPace(from seconds: Double) -> String {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: seconds) ?? "00:00"
    }
    
    func startCountdownTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                self.stopTimer()
                self.pauseRun()
                self.resetRun()
                self.currentFullScreenCover = .workout
            }
        })
    }
    
    func startWorkoutTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            if !self.workoutIsPaused {
                self.elapsedTime += 0.1
            } else {
                self.stopTimer()
            }
            if self.distance > 0 {
                let secondsPerMile = self.elapsedTime / (self.distance * self.mileMultipler)
                
                let minutes = Int(secondsPerMile / 60)
                let seconds = Int(secondsPerMile) % 60
                
                self.pace = String(format: "%02d:%02d", minutes, seconds)
            }
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resumeRun() {
        startWorkoutTimer()
        locationService.startUpdatingLocation()
    }
    
    func pauseRun() {
        stopTimer()
        locationService.stopUpdatingLocation()
        locationService.invalidateLastLocation()
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
    }
    
    func resetRun() {
        elapsedTime = 0.0
        locationList = []
        locationService.resetRunData()
    }
    
    func exitRun() {
        countdown = 3
        presentFullScreenCover = false
    }
    
    func stopRun() {
        resetRun()
        exitRun()
    }
    
    func saveRunData() async {
        let currentRun = Run(
            id: nil,
            createdAt: nil,
            distance: convertToMile(from: distance),
            elpasedTime: converToTimerFormat(from: elapsedTime),
            pace: convertToPace(from: distance),
            title: runTitle)
        
        do {
            try await dataService.saveRun(newRun: currentRun)
            print("✅ Run saved successfully.")
        } catch {
            print("❌ Error saving run: \(error.localizedDescription)")
        }
    }
    
    func fetchRunData() async {
        do {
            let results = try await dataService.fetchRunData()
            
            await MainActor.run {
                self.runs = results
            }
            print("✅ Run fetched successfully.")
        } catch {
            print("❌ Error fetching runs: \(error.localizedDescription)")
        }
    }
}

