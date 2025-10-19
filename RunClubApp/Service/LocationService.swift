//
//  LocationService.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import CoreLocation
import _MapKit_SwiftUI
import Foundation

//TODO: Add some comments to undestand this
class LocationService: NSObject, ObservableObject {
    @Published var displayRegion: MapCameraPosition = .region(MKCoordinateRegion())
    @Published var distanceCovered: Double = 0.0
    
    /// Using this to generate/render the map based on the user location
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
    
    func resetLocation() {
        startLocation = nil
        lastLocation = nil
        distanceCovered = 0.0
    }
}

// MARK: handles user pop-up to allow location tracking and updates user location
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        if let lastLocation = lastLocation {
            if let distanceIncrement = startLocation?.distance(from: lastLocation) {
                distanceCovered += distanceIncrement
            }
        }
        
        mapRegion = newLocation.coordinate
        
        updateDisplayRegion()
        
        if startLocation == nil {
            startLocation = newLocation
            return
        }
        
        lastLocation = newLocation
    }
}
