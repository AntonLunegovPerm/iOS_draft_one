//
//  LocationService.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import CoreLocation
import MapKit

typealias LocationServiceLocationUpdated = (() -> Void)

protocol LocationServiceProtocol {
    
    func calculateDistance(to location: CLLocation) -> CLLocationDistance?
    func distanceFormatted(from location: CLLocation) -> String?
    func startUpdatingLocation()
    
    var onLocationUpdated: LocationServiceLocationUpdated? { get set }
}

class LocationService: NSObject {
    
    private var _onLocationUpdate: LocationServiceLocationUpdated?
    private let locationManager: CLLocationManager
    private var userLocation: CLLocation?
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let firstUpdate = userLocation == nil
        
        userLocation = locations.first
        
        if firstUpdate {
            self.onLocationUpdated?()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .denied {
            locationManager.startUpdatingLocation()
        }
    }
}

extension LocationService: LocationServiceProtocol {
    
    var onLocationUpdated: LocationServiceLocationUpdated? {
        get {
            return _onLocationUpdate
        }
        set {
            _onLocationUpdate = newValue
        }
    }
    
    func calculateDistance(to location: CLLocation) -> CLLocationDistance? {
        return userLocation?.distance(from: location)
    }
    
    func distanceFormatted(from location: CLLocation) -> String? {
        guard let distance = calculateDistance(to: location) else { return nil }
        let distanceFormatter = MKDistanceFormatter()
        distanceFormatter.locale = Locale.current
        
        var distanceAndUnitString = distanceFormatter.string(fromDistance: distance)
        return distanceAndUnitString
    }
    
    func startUpdatingLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
}
