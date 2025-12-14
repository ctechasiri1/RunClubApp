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
    @Published var locationList: [CLLocationCoordinate2D] = []
    
    @Published var runTitle: String = ""
    @Published var pace: String = "00:00"
    @Published var distance: Double = 0.0
    @Published var elapsedTime: Double = 0.0
    
    @Published var elevation: Double = 0
    @Published var heartRate: Double = 0
    @Published var activeEnergy: Double = 0
    
    @Published var errorMessage: String?
    @Published var workoutIsPaused: Bool = false
    @Published var workoutStarted: Bool = false
    
    private let locationService: MapKitManager
    private let dataManager: DataManager
    private var isAuthorized: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    
    init(locationService: MapKitManager = MapKitManager(), dataManager: DataManager = SupabaseDataManager.shared) {
        self.locationService = locationService
        self.dataManager = dataManager
        addSubscriber()
    }
    
    private func addSubscriber() {
        locationService.$displayRegion
            .sink { [weak self] newDisplayRegion in
                self?.displayRegion = newDisplayRegion
            }
            .store(in: &cancellables)
        
        locationService.$distanceCovered
            .sink { [weak self] newDistance in
                self?.distance = newDistance
                
                if newDistance > 0 {
                    if let elpasedTime = self?.elapsedTime,
                       let distance = self?.distance {
                        let secondsPerMile = elpasedTime / (distance * Constants.mileMultiplier)
                        
                        let minutes = Int(secondsPerMile / 60)
                        let seconds = Int(secondsPerMile) % 60
                        
                        self?.pace = String(format: "%02d:%02d", minutes, seconds)
                    }
                }
            }
            .store(in: &cancellables)
        
        locationService.$elevationGained
            .sink { [weak self] elevationGain in
                self?.elevation = elevationGain
            }
            .store(in: &cancellables)
        
        locationService.$locationList
            .sink { [weak self] newLocationList in
                self?.locationList = newLocationList
            }
            .store(in: &cancellables)
    }
    
    func startWorkoutTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            if !self.workoutIsPaused && self.workoutStarted {
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
        workoutStarted = true
        startWorkoutTimer()
        locationService.startUpdatingLocation()
    }
    
    func pauseRun() {
        locationService.stopUpdatingLocation()
        locationService.invalidateLastLocation()
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
    }
    
    func resetRun() {
        stopTimer()
        workoutStarted = false
        elapsedTime = 0.0
        locationList = []
        locationService.resetRunData()
        runTitle = ""
    }
    
    func saveRunData() async throws {
        let codableCoordinates = locationList.map { Coordinate(latitude: $0.latitude, longitude: $0.longitude) }
        let elevationGained = locationService.elevationGained

        if let userID = await SupabaseAuthManager.shared.currentSession?.user.id {
            let currentRun = Run(
                id: nil,
                title: runTitle,
                createdAt: nil,
                distance: distance.convertToMile(),
                elpasedTime: elapsedTime.converToTimerFormat(),
                pace: distance.convertToPace(),
                elevationGain: elevationGained,
                coordinates: codableCoordinates,
                userID: userID
            )
            try await dataManager.saveRun(added: currentRun)
        }

        print("✅ Run saved successfully.")
    }
}

