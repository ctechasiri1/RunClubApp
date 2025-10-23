//
//  AuthService.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/18/25.
//

import ConfidentialKit
import Foundation
import Supabase

final class SupabaseManager {
    private let apiKey = "\(Secrets.$apiKey)"
    private let apiUrl = "\(Secrets.$apiUrl)"
    
    static let shared = SupabaseManager()
    let client: SupabaseClient

    init() {
        self.client = SupabaseClient(supabaseURL: URL(string: apiUrl)!, supabaseKey: apiKey)
    }
    
    func saveRun(newRun: Run) async throws {
        try await client
            .from("Runs")
            .insert(newRun)
            .execute()
    }
    
    func fetchRunData() async throws -> [Run] {
        try await client
            .from("Runs")
            .select()
            .execute()
            .value
    }
}
