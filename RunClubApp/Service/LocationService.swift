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
}

// MARK: handles user pop-up to allow location tracking and updates user location
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        mapRegion = location.coordinate
        
        updateDisplayRegion()
        
        if startLocation == nil {
            startLocation = location
            return
        }
        
        lastLocation = location
    }
}
