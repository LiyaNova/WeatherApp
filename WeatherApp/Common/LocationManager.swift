//
//  LocationManager.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//
    
import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func askLocationPermission()
    func useUserLocation(latitude: Double?, longitude: Double?)
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    weak var locationManagerDelegate: LocationManagerDelegate?
    private let manager = CLLocationManager()

     override init() {
        super.init()
         manager.delegate = self
    }

    private func enableLocationFeatures() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 300
        manager.startUpdatingLocation()
    }
}

extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.last else { return }
        locationManagerDelegate?.useUserLocation(latitude: coordinates.coordinate.latitude,
                                                 longitude: coordinates.coordinate.longitude)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            enableLocationFeatures()
        case .restricted, .denied:
            locationManagerDelegate?.askLocationPermission()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (error as? CLError)?.code == .denied {
            manager.stopUpdatingLocation()
            manager.stopMonitoringSignificantLocationChanges()
        }
    }
}
