//
//  LocationManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 26/05/2022.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // activity indicator logic should be somewhere else
            activityIndicator.isHidden = false
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            service.fetchWeather(latitude: lat, longitude: lon)
            //            service.fetchWeather(latitude: lat, longitude: lon) { [weak self] result in
            //                switch result {
            //                case .success(let weather):
            //                    self?.updateUI(with: weather)
            //                case .failure(let error):
            //                    DispatchQueue.main.async {
            //                        self?.showErrorAlert(error)
            //                    }
            //                }
            //            }
        }
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showErrorAlert(.invalidCityName)
    }
}
    





