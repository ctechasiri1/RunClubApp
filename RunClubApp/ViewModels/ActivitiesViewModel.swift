//
//  ActivitiesViewModel.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/27/25.
//


import Foundation

@MainActor
class ActivitiesViewModel: ObservableObject {
    @Published var runs: [Run] = []
    
    private let dataManager: DataManager
    
    init(dataManager: DataManager = SupabaseDataManager.shared) {
        self.dataManager = dataManager
    }
    
    func fetchRunData() async {
        do {
            self.runs = try await dataManager.fetchRunData()
            print("✅ Run fetched successfully.")
        } catch {
            print("❌ Error fetching runs: \(error.localizedDescription)")
        }
    }
}
