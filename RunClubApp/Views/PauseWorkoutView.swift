//
//  PauseWorkoutView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/18/25.
//

import SwiftUI
import _MapKit_SwiftUI

struct PauseWorkoutView: View {
    @EnvironmentObject private var viewModel: RunTrackerViewModel
    
    var body: some View {
        Spacer()
        
        VStack {
            
            distanceCard
            
            HStack {
                card(imageName: MetricCard.pace.imageName, meteric: MetricCard.pace.title, data: "0.00", unit: MetricCard.pace.unitOfMeasurement)
                card(imageName: MetricCard.duration.imageName, meteric: MetricCard.duration.title, data: "00:00:00", unit: MetricCard.duration.unitOfMeasurement)
            }
            
            HStack {
                card(imageName: MetricCard.elevation.imageName, meteric: MetricCard.elevation.title, data: "00", unit: MetricCard.elevation.unitOfMeasurement)
                card(imageName: MetricCard.heartrate.imageName, meteric: MetricCard.heartrate.title, data: "000", unit: MetricCard.heartrate.unitOfMeasurement)
            }
            
            Spacer()
            
            Map(position: $viewModel.displayRegion) {
                MapPolyline(coordinates: viewModel.locationList)
                    .stroke(.blue, lineWidth: 5)
            }
            .frame(height: (UIScreen.main.bounds.height / 4))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.bottom)
            
            Spacer()
            
            HStack(spacing: 20) {
                resumeButton
                finishButton
            }
            
            Spacer()
        }
        .padding()
        .ignoresSafeArea()
    }
}

#Preview {
    PauseWorkoutView()
        .environmentObject(RunTrackerViewModel(locationService: LocationService()))
}

extension PauseWorkoutView {
    private var distanceCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "ruler.fill")
                Text("TOTAL DISTANCE")
            }
            .foregroundStyle(.gray)
            .padding(.top)
            
            Text("0.00")
                .font(.system(size: 60, weight: .bold, design: .default))
            Text("MILES")
                .foregroundStyle(.gray)
                .padding(.bottom)
        }
        .padding(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 150)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.top, 60)
    }
    
    private func card(imageName: String, meteric: String, data: String, unit: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: imageName)
                Text(meteric)
            }
            .padding(.top)
            
            Text(data)
                .font(.system(size: 30, weight: .bold))
            Text(unit)
                .foregroundStyle(.gray)
                .padding(.bottom)
        }
        .padding(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 120)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(5)
    }
    
    private var resumeButton: some View {
        Button {
            
        } label: {
            HStack {
                Text("Resume")
                Image(systemName: "play.fill")
            }
            .foregroundStyle(.white)
            .font(.system(.title3, design: .default, weight: .semibold))
            .frame(width: 180, height: 60)
            .background(.primaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
    
    private var finishButton: some View {
        Button {
            
        } label: {
            HStack {
                Text("Finish")
                Image(systemName: "square.circle")
            }
            .foregroundStyle(.white)
            .font(.system(.title3, design: .default, weight: .semibold))
            .frame(width: 180, height: 60)
            .background(.primaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}
