//
//  ActivitiesViewModel.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/27/25.
//

import CoreLocation
import Foundation

@MainActor
class ActivitiesViewModel: ObservableObject {
    @Published var locationList: [Int: [CLLocationCoordinate2D]] = [:]
    @Published var runs: [Run] = []
    @Published var isLoading = false
    
    let dataManager: DataManager = SupabaseDataManager.shared
    
    func fetchRunData(for userID: UUID) async {
        self.isLoading = true
        do {
            self.runs = try await dataManager.fetchRunData(for: userID)
            
            for run in runs {
                if let runID = run.id {
                    self.locationList[runID] = [CLLocationCoordinate2D]()
                    for coordinate in run.coordinates {
                        self.locationList[runID]?.append(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
                    }
                }
            }
            
            self.isLoading = false
            print("✅ Run fetched successfully.")
        } catch {
            print("❌ Error fetching runs: \(error.localizedDescription)")
        }
    }
}
