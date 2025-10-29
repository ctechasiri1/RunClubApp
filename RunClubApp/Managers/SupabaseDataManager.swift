//
//  SupabaseDataManager.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/18/25.
//

import ConfidentialKit
import Foundation
import Supabase

final class SupabaseDataManager: DataManager {
    static let shared = SupabaseDataManager()
    
    private let client: SupabaseClient
    private let apiKey = "\(Secrets.$apiKey)"
    private let apiUrl = "\(Secrets.$apiUrl)"
    
    init() {
        let url = URL(string: apiUrl)!
        self.client = SupabaseClient(supabaseURL: url, supabaseKey: apiKey)
    }
    
    func saveRun(added: Run) async throws {
        try await client
            .from("Runs")
            .insert(added)
            .execute()
    }
    
    func fetchRunData(for userID: UUID) async throws -> [Run] {
        try await client
            .from("Runs")
            .select()
            .in("user_ID", values: [userID])
            .execute()
            .value
    }
}
