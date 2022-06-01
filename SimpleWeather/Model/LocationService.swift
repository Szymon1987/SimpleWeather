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

typealias LocationCompletionBlock = (Result<Location, WeatherError>) -> Void

protocol LocationProvider {
    func requestLocation(then: @escaping LocationCompletionBlock)
}

class LocationService: NSObject, LocationProvider {

    private var locationManager: LocationManager
    var locationCompletionBlock: LocationCompletionBlock?
        
    init(locationManager: LocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestLocation(then: @escaping LocationCompletionBlock) {
        self.locationCompletionBlock = then
        locationManager.requestWhenInUseAuthorization()
        let status = locationManager.authorizationStatus
        if (status == .restricted || status == .denied) {
            then(.failure(.allowAccess))
            return
        } else if (status == .notDetermined) {
            locationManager.requestWhenInUseAuthorization()
            return
        } else {
            locationManager.requestLocation()
        }
    }
}
    
extension LocationService: CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                locationManager.stopUpdatingLocation()
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                let location = Location(latitude: lat, longitude: lon)
                locationCompletionBlock?(.success(location))
            } else {
                locationCompletionBlock?(.failure(.locationError))
            }
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            locationCompletionBlock?(.failure(.locationError))
        }
    }

extension CLLocationManager: LocationManager {}










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

