//
//  Tab.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import Foundation

enum Tab: CaseIterable {
    case home, activity
    
    var title: String {
        switch self {
        case .home:
            "Home"
        case .activity:
            "Activity"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            "house.fill"
        case .activity:
            "chart.line.uptrend.xyaxis"
        }
    }
}
