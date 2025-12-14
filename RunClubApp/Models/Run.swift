//
//  Run.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/21/25.
//

import Foundation

struct Run: Codable, Identifiable {
    let id: Int?
    let createdAt: Date?
    let distance: String
    let elpasedTime: String
    let pace: String
    let title: String
    let coordinates: [Coordinate]
    let userID: UUID
    
    enum CodingKeys: String, CodingKey {
        case id, distance, pace, title, coordinates
        case createdAt = "created_at"
        case elpasedTime = "elapsed_time"
        case userID = "user_ID"
    }
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}
