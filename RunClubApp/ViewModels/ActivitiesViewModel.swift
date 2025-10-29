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
    
    private let dataManager: DataManager
    
    init(dataManager: DataManager = SupabaseDataManager.shared) {
        self.dataManager = dataManager
    }
    
    func fetchRunData(for userID: UUID) async {
        self.isLoading = true
        do {
            self.runs = try await dataManager.fetchRunData(for: userID)
            self.isLoading = false
            print("✅ Run fetched successfully.")
        } catch {
            print("❌ Error fetching runs: \(error.localizedDescription)")
        }
    }
    
    func fetchLocationData() {
        for run in runs {
            if let runID = run.id {
            let startLocation = CLLocationCoordinate2D(latitude: run.startLatitude, longitude: run.startLongitude)
            let endLocation = CLLocationCoordinate2D(latitude: run.endLatitude, longitude: run.endLongitude)
                locationList[runID] = [startLocation, endLocation]
            }
        }
    }
    
    func iso8601Formatter(for oldDate: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return formatter.string(from: oldDate)
    }
}
