//
//  Date.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 12/13/25.
//

import Foundation

extension Date {
    func iso8601Formatter() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return formatter.string(from: self)
    }
}
