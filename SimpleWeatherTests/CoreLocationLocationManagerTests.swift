//
//  CoreLocationLocationManagerTests.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 24/06/2022.
//

import XCTest
@testable import SimpleWeather
import CoreLocation


class CoreLocationLocationManagerTests: XCTestCase {
    
//    func test_requestlocation_when_acces_not_autorised() {
//
//        var results: Result<Location, LocationError>?
//        let sut = CoreLocationLocationManager()
//        sut.internalLocationManager = MockLocationManager()
//        sut.internalLocationManager.authorizationStatus = .authorizedAlways
//        sut.requestLocation { result in
////            sut.internalLocationManager.requestLocation()
//            results = result
//        }
//        XCTAssertNotNil(results)
//        XCTAssertNotNil(sut.internalLocationManager.location)
//        XCTAssertThrowsError()
//
//    }
}


//extension CLLocationManager: CLLocationManagerProtocol {}


class MockLocationManager: CLLocationManagerProtocol {
    
    
    var location: CLLocation?
    
    var delegate: CLLocationManagerDelegate?
    
    var authorizationStatus: CLAuthorizationStatus {
        get { return self.authorizationStatus}
        set {
            return self.authorizationStatus = newValue
        }
    }
    
    func requestWhenInUseAuthorization() {
        
    }
    func requestLocation() {
        location = CLLocation(latitude: 4.44, longitude: 19.009)
    }
    func stopUpdatingLocation() {
        
    }
    
}
