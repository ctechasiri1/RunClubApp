//
//  SupabaseAuthManager.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/28/25.
//

import ConfidentialKit
import Combine
import Foundation
import Supabase

@MainActor
final class SupabaseAuthManager: ObservableObject {
    static let shared = SupabaseAuthManager()
    
    @Published var currentSession: Session?
    
    private let client: SupabaseClient
    private let apiKey = "\(Secrets.$apiKey)"
    private let apiUrl = "\(Secrets.$apiUrl)"
    
    init() {
        let url = URL(string: apiUrl)!
        self.client = SupabaseClient(supabaseURL: url, supabaseKey: apiKey)
        
        Task {
            currentSession = try await client.auth.session
        }
    }
    
    func magicLinkLogin(userEmail: String) async throws {
        try await client.auth.signInWithOTP(
            email: userEmail,
            redirectTo: URL(string: "com.yak-club://login-callback")
        )
    }
    
    func handleOpenURL(url: URL) async throws {
        print("currentSession is being set")
        currentSession = try await client.auth.session(from: url)
        
        guard let currentSessionHasValue = currentSession else { return }
        print("current session: \(currentSessionHasValue)")
    }
    
    func logout() async throws {
        try await client.auth.signOut()
        currentSession = nil
    }
}
