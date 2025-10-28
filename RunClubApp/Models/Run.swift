//
//  Run.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/21/25.
//

import Foundation

struct Run: Codable {
    let id: Int?
    let createdAt: Date?
    let distance: String
    let elpasedTime: String
    let pace: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case distance
        case elpasedTime = "elapsed_time"
        case pace
        case title
    }
}
