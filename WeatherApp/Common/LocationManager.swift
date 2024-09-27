//
//  LocationManager.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    var status: CLAuthorizationStatus {
        manager.authorizationStatus
    }
    
    private let manager = CLLocationManager()
    
    private override init() {
        super.init()
        manager.delegate = self
    }
    
    private func enableLocationFeatures() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 300
        manager.startUpdatingLocation()
    }
}

//MARK: - LocationManager extension
extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.last else { return }
        
        let userInfo = ["latitude": coordinates.coordinate.latitude, "longitude": coordinates.coordinate.longitude]
        NotificationCenter.default.post(name: .useUserLocation, object: nil, userInfo: userInfo)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            enableLocationFeatures()
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

//MARK: - Notification name
extension Notification.Name {
    static let useUserLocation = Notification.Name("useUserLocation")
}
