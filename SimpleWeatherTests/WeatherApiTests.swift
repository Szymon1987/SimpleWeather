//
//  WeatherApiTests.swift
//  SimpleWeatherTests
//
//  Created by Szymon Tadrzak on 01/06/2022.
//

import XCTest
@testable import SimpleWeather

class WeatherApiTests: XCTestCase {
    
    var weatherApiService: WeatherApiService!


    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

}

class LocationServiceMock: LocationService {
    
}
