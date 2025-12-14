//
//  Double.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 12/13/25.
//

import Foundation

extension Double {
    /// this converts 'distance' (recorded in meters) to the formatted miles
    func convertToMile() -> String {
        let distanceInMile = (self * Constants.mileMultiplier)
        return String(format: "%.2f", distanceInMile)
    }
    
    /// this converts 'elpasedTime' (recorded in seconds) to the foramtted time
    func converToTimerFormatWorkout() -> String {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.hour, .minute, .second]
        
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: self) ?? "00:00:00"
    }
    
    /// this converts 'elpasedTime' (recorded in seconds) to the foramtted time
    func converToTimerFormatPauseWorkout() -> String {
        let formatter = DateComponentsFormatter()
        
        if self >= 3600 {
            formatter.allowedUnits = [.hour, .minute, .second]
        } else {
            formatter.allowedUnits = [.minute, .second]
        }
        
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: self) ?? "00:00"
    }
    
    /// this converts 'pace' (recorded in seconds) to the formatted time
    func convertToPace() -> String {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: self) ?? "00:00"
    }
    
    func convertToFeet() -> String {
        let distance = Measurement(value: self, unit: UnitLength.meters)
        let distanceInFeet = distance.converted(to: .feet)
        let resultString = distanceInFeet.value.formatted()
        
        return resultString
    }
}
