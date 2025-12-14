//
//  TechnicalMetricView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import SwiftUI

struct TechnicalMetricView: View {
    let metericImage: String
    let metricName: String
    let metricValue: String
    let metricUnit: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: metericImage)
                .foregroundStyle(color.opacity(0.6))
            
            Text(metricName)
            
            Spacer()
            
            Text(metricValue)
                .font(.system(.title3, design: .default, weight: .bold))
            
            Text(metricUnit)
                .foregroundStyle(.gray)
        }
        .padding(8)
    }
}

#Preview {
    TechnicalMetricView(metericImage: "heart.fill", metricName: "Average Heart Rate", metricValue: "0.0", metricUnit: "BPM", color: Color.pink)
}
