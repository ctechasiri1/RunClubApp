//
//  LoginViewModel.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/28/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    
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
