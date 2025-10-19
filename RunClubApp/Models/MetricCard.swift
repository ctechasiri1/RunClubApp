//
//  MetricCard.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/19/25.
//

import Foundation

enum MetricCard: CaseIterable {
    case pace, duration, elevation, heartrate
    
    var title: String {
        switch self {
        case .pace:
            return "Avg. Pace"
        case .duration:
            return "Duration"
        case .elevation:
            return "Elevation Gain"
        case .heartrate:
            return "Avg. HR"
        }
    }
    
    var imageName: String {
        switch self {
        case .pace:
            return "fitness.timer"
        case .duration:
            return "lungs"
        case .elevation:
            return "chart.line.uptrend.xyaxis"
        case .heartrate:
            return "heart"
        }
    }
    
    var unitOfMeasurement: String {
        switch self {
        case .pace:
            return "MIN/MI"
        case .duration:
            return  "TIME ELAPSED"
        case .elevation:
            return "FT"
        case .heartrate:
            return "BPM"
        }
    }
}
