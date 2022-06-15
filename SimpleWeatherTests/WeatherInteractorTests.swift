//
//  WeatherInteractorTests.swift
//  SimpleWeatherTests
//
//  Created by Szymon Tadrzak on 14/06/2022.
//

import XCTest
@testable import SimpleWeather

class WeatherInteractorTests: XCTestCase {
    
    
    
}


class MockLocationManager: LocationManager {
    func requestLocation(completion: @escaping LocationCompletionBlock) {}
}
