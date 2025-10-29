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
    let startLatitude: Double
    let startLongitude: Double
    let endLatitude: Double
    let endLongitude: Double
    let userID: UUID
    
    enum CodingKeys: String, CodingKey {
        case id, distance, pace, title
        case createdAt = "created_at"
        case elpasedTime = "elapsed_time"
        case startLongitude = "start_longitude"
        case startLatitude = "start_latitude"
        case endLongitude = "end_longitude"
        case endLatitude = "end_latitude"
        case userID = "user_ID"
    }
}
