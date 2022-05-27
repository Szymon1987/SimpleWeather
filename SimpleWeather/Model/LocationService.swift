//
//  LocationManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 26/05/2022.
//

import Foundation
import CoreLocation

enum LocationError: String, Error {
    case locationError = "Error fetching location. Please try again"
}

class LocationService: NSObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    var actionForLocacion: ((CLLocationDegrees, CLLocationDegrees) -> Void)?
//    var newActionForLocation: ((Result<Location, LocationError>) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            actionForLocacion?(lat,lon)
//            let location = Location(latitude: lat, longitude: lon)
//            newActionForLocation?(.success(location))
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error")
//        newActionForLocation?(.failure(.locationError))
    }
    
    public func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status {
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
            manager.requestLocation()
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            manager.requestLocation()
        case .authorized:
            print("authorized")
            manager.requestLocation()
        @unknown default:
            fatalError()
        }
    }
}
    





