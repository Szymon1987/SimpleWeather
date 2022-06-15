//
//  CoreLocationLocationManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 10/06/2022.
//

import Foundation
import CoreLocation

class CoreLocationLocationManager: NSObject {
    //MARK: - Properties
    private let internalLocationManager = CLLocationManager()
    private var completionBlock: LocationCompletionBlock?
    
    override init() {
        super.init()
        internalLocationManager.delegate = self
    }

    //MARK: - CoreLocation Private Methods
    private func isAccessToLocationAuthorized() -> Bool {
        return  internalLocationManager.authorizationStatus == .authorizedAlways ||
                internalLocationManager.authorizationStatus == .authorizedWhenInUse
    }
    
    private func isAccessAlreadyRequested() -> Bool {
        return  !(internalLocationManager.authorizationStatus == .notDetermined)
    }
    
    private func requestAccess() {
        internalLocationManager.requestWhenInUseAuthorization()
    }
}

//MARK: - LocationManager Protocol Conformance
extension CoreLocationLocationManager: LocationManager {
    func requestLocation(completion: @escaping LocationCompletionBlock) {
        completionBlock = completion
        if (isAccessToLocationAuthorized()) {
            internalLocationManager.requestLocation()
        } else if (!isAccessAlreadyRequested()) {
            requestAccess()
        } else {
            completion(.failure(LocationError.deniedAccess))
        }
    }
}

//MARK: - CLLocationManagerDelegate Methods
extension CoreLocationLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            internalLocationManager.stopUpdatingLocation()
            let location = Location(latitude: location.coordinate.latitude,
                                    longitude: location.coordinate.longitude)
            complete(with: .success(location))
        } else {
            complete(with: .failure(LocationError.unknown))
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        complete(with: .failure(LocationError.unknown))
    }
    
    //MARK: Helpers
    private func complete(with state: Result<Location, LocationError>) {
        if let completionBlock = completionBlock {
            completionBlock(state)
        }
    }
}
