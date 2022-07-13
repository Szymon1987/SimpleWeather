//
//  URLSessionWeatherAPIManagerTests.swift
//  SimpleWeatherTests
//
//  Created by Szymon Tadrzak on 13/06/2022.
//

import XCTest
@testable import SimpleWeather

class URLSessionWeatherAPIManagerTests: XCTestCase {

    func test_completion_with_invalid_cityname() {
        let sut = URLSessionWeatherAPIManagerMock()

    }
}



class URLSessionWeatherAPIManagerMock: WeatherAPIManager {
    
    func fetchWeatherData(for cityName: String, completion: @escaping WeatherAPICompletionBlock) {
        completion(.failure(.invalidCityName))
    }
    
    func fetchWeatherData(for location: Location, completion: @escaping WeatherAPICompletionBlock) {
        
    }
}
