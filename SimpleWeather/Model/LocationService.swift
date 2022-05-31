//
//  LocationManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 26/05/2022.
//

import Foundation
import CoreLocation

protocol LocationManager {
    var delegate: CLLocationManagerDelegate? { get set }
    var authorizationStatus: CLAuthorizationStatus { get }
    func requestWhenInUseAuthorization()
    func requestLocation()
    func stopUpdatingLocation()
}

class LocationService: NSObject, CLLocationManagerDelegate {

    private var locationManager: LocationManager
    var completion: ((Result<Location, WeatherError>) -> Void)?
//    var allowLocationAccess: ((String) -> Void)?
        
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
    }
    
    public func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        let status = locationManager.authorizationStatus
        if (status == .restricted || status == .denied) {
            completion?(.failure(.allowAccess))
//            allowLocationAccess?("Allow 'SimpleWeather' to access yout location in the device Settings")
            return
        } else if (status == .notDetermined) {
            locationManager.requestWhenInUseAuthorization()
            return
        } else {
            locationManager.requestLocation()
        }
    }
    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        let status = manager.authorizationStatus
//        switch status {
//        case .notDetermined:
//            print("notDetermined")
//        case .restricted:
//            print("restricted")
//        case .denied:
//            print("denied")
//        case .authorizedAlways:
//            print("authorizedAlways")
//            manager.requestLocation()
//        case .authorizedWhenInUse:
//            print("authorizedWhenInUse")
//            manager.requestLocation()
//        case .authorized:
//            print("authorized")
//            manager.requestLocation()
//        @unknown default:
//            fatalError()
//        }
//    }
}

extension LocationService {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            let location = Location(latitude: lat, longitude: lon)
            completion?(.success(location))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(.locationError))
    }
}

extension CLLocationManager: LocationManager{}




