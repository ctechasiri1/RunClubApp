//
//  RunTrackerViewModel.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import Combine
import _MapKit_SwiftUI
import Foundation
import AudioToolbox

class RunTrackerViewModel: ObservableObject {
    /// for rendering the coorindates in map from location service
    @Published var displayRegion: MapCameraPosition = .region(MKCoordinateRegion())
    
    /// for the 'CountdownView' 
    @Published var presentCountdown: Bool = false
    @Published var countdown: Int = 3
    
    @Published var selectedTab: Tab = .home
    
    @Published var workoutIsPaused: Bool = false
    @Published var presentWorkout: Bool = false
    @Published var distance: Double = 0.0
    @Published var elapsedTime: Double = 0.0
    @Published var pace: String = "00:00"
    
    @Published var presentPauseWorkout: Bool = false
    @Published var locationList: [CLLocationCoordinate2D] = []
    
    private let mileMultipler = 0.000621371
    private let locationService: LocationService
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    
    init(locationService: LocationService) {
        self.locationService = locationService
        addSubscriber()
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
    
    func startCountdownTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                self.stopTimer()
                self.presentWorkout = true
            }
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func convertToMile(from distance : Double) -> String {
        let distanceInMile = (distance * mileMultipler)
        return String(format: "%.2f", distanceInMile)
    }
    
    func converToTimerFormat(from seconds: Double) -> String {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: seconds) ?? "00:00:00"
    }
    
    func convertToPace(from seconds: Double) -> String {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: seconds) ?? "00:00"
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
    
    func resumeWorkout() {
        locationService.startUpdatingLocation()
    }
    
    func pauseWorkout() {
        locationService.stopUpdatingLocation()
        locationService.invalidateLastLocation()
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
    }
    
    func resetWorkout() {
        elapsedTime = 0.0
        locationService.resetLocation()
    }
    
    func exitWorkout() {
        countdown = 3
        presentCountdown = false
    }
}

