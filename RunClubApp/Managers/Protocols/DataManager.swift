//
//  DataManager.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/27/25.
//

import Foundation

protocol DataManager {
    func saveRun(added: Run) async throws
    func fetchRunData() async throws -> [Run]
}
