//
//  LocationManager.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import CoreLocation
import _MapKit_SwiftUI
import Foundation

class MapKitManager: NSObject, ObservableObject {
    @Published var displayRegion: MapCameraPosition = .region(MKCoordinateRegion())
    @Published var locationList: [CLLocationCoordinate2D] = []
    @Published var distanceCovered: Double = 0.0
    @Published var elevationGained: Double = 0.0
    
    private let locationManager = CLLocationManager()
    private let mapZoom = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

    /// Location Tracking
    private var startLocation: CLLocation?
    private var lastLocation: CLLocation?
    private var mapRegion: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func updateDisplayRegion() {
        guard let unWrappedMapRegion = mapRegion else { return }
        displayRegion = .region(MKCoordinateRegion(center: unWrappedMapRegion, span: mapZoom))
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func invalidateLastLocation() {
        lastLocation = nil
    }
    
    func resetRunData() {
        startLocation = nil
        lastLocation = nil
        distanceCovered = 0.0
    }
}

// MARK: handles user pop-up to allow location tracking and updates user location
extension MapKitManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        /// grabs the latest location
        guard let newLocation = locations.last else { return }
        
        /// calculates the new distance from the last distance
        if let lastLocation = self.lastLocation {
            let distanceIncrement = lastLocation.distance(from: newLocation)
            distanceCovered += distanceIncrement
            
            let elevationGain = newLocation.altitude - lastLocation.altitude
            elevationGained += elevationGain
        }
        
        /// updates the map  to the new location
        mapRegion = newLocation.coordinate
        
        updateDisplayRegion()
        
        /// if there is a new coordinate generated add it to the locationList
        if startLocation == nil {
            startLocation = newLocation
            locationList.append(newLocation.coordinate)
            return
        }
        
        /// update the last location to the new location and append it to the locationList
        lastLocation = newLocation
        locationList.append(newLocation.coordinate)
    }
}
