//
//  LiveRunViewModel.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import AudioToolbox
import Combine
import _MapKit_SwiftUI
import Foundation
import HealthKit

class LiveRunViewModel: ObservableObject {
    @Published var displayRegion: MapCameraPosition = .region(MKCoordinateRegion())
    @Published var pace: String = "00:00"
    @Published var distance: Double = 0.0 {
        didSet {
            if distance > 0 {
                let secondsPerMile = self.elapsedTime / (self.distance * self.mileMultipler)
                
                let minutes = Int(secondsPerMile / 60)
                let seconds = Int(secondsPerMile) % 60
                
                self.pace = String(format: "%02d:%02d", minutes, seconds)
            }
        }
    }
    @Published var elapsedTime: Double = 0.0
    @Published var workoutIsPaused: Bool = false
    @Published var runTitle: String = ""
    @Published var locationList: [CLLocationCoordinate2D] = []
    
    @Published var flightCount: Double = 0
    @Published var heartRate: Double = 0
    @Published var activeEnergy: Double = 0
    @Published var errorMessage: String?
    
    private let mileMultipler = 0.000621371
    private let locationService: MapKitManager
    private let dataManager: DataManager
    private var isAuthorized: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    
    init(locationService: MapKitManager = MapKitManager(), dataManager: DataManager = SupabaseDataManager.shared) {
        self.locationService = locationService
        self.dataManager = dataManager
        addSubscriber()
        Task { await requestAuthorization() }
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
    
    func startWorkoutTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            if !self.workoutIsPaused {
                self.elapsedTime += 0.1
            } else {
                self.stopTimer()
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
        runTitle = ""
    }
    
    func saveRunData() async throws {
        if let startLocation = locationList.first, let endLocation = locationList.last {
            let currentRun = Run(
                id: nil,
                createdAt: nil,
                distance: convertToMile(from: distance),
                elpasedTime: converToTimerFormat(from: elapsedTime),
                pace: convertToPace(from: distance),
                title: runTitle,
                startLatitude: startLocation.latitude,
                startLongitude: startLocation.longitude,
                endLatitude: endLocation.latitude,
                endLongitude: endLocation.longitude
            )
            try await dataManager.saveRun(added: currentRun)
        }

        print("✅ Run saved successfully.")
    }
}

