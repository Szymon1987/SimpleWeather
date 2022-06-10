//
//  WeatherApiTests.swift
//  SimpleWeatherTests
//
//  Created by Szymon Tadrzak on 01/06/2022.
//

import XCTest
@testable import SimpleWeather

class WeatherApiServiceTests: XCTestCase {
    
    var sut: WeatherApiService!
    var locationProvider: LocationProviderMock!
    var urlString: String!


    override func setUp() {
        super.setUp()
        locationProvider = LocationProviderMock()
        urlString = "dupa"
        sut = WeatherApiService(locationProvider: locationProvider, urlString: urlString)
    }
    
    override func tearDown() {
        sut = nil
        locationProvider = nil
        urlString = nil
        super.tearDown()
    }
    
//    func test_fetchWeatherForLocation_returns_location() {
//        locationProvider.provideLocation { result in
//            let location = result(Location(latitude: 0.123, longitude: 45.988))
//        }
//    }
}

class LocationProviderMock: LocationProvider {
    
//    var location = Location(latitude: 0.343, longitude: 45.984)
    
    func provideLocation(then: @escaping LocationCompletionBlock) {
        
        
    }
}



