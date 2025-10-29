//
//  LoginViewModel.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/28/25.
//

import Combine
import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var validSession: Bool = false
    
    // 2. Add a place to store our subscription
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // 3. Subscribe to changes from the Auth Manager
        SupabaseAuthManager.shared.$currentSession
            .receive(on: RunLoop.main) // Ensure UI updates are on the main thread
            .sink { [weak self] session in
                // This code now runs EVERY time the session changes
                self?.validSession = (session != nil)
                print("Session changed. Valid session is now: \(self?.validSession ?? false)")
            }
            .store(in: &cancellables)
    }
    
    func loginAction() {
        Task {
            do {
                try await SupabaseAuthManager.shared.magicLinkLogin(userEmail: email)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func handleMagicLink(url: URL) {
        Task {
            do {
                try await SupabaseAuthManager.shared.handleOpenURL(url: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
