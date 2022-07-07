//
//  WeatherInteractorTests.swift
//  SimpleWeatherTests
//
//  Created by Szymon Tadrzak on 15/06/2022.
//

import XCTest
@testable import SimpleWeather

class WeatherInteractorTests: XCTestCase {
    
    func test_viewDidLoad() {
        let sut = makeSUT()
        sut.viewDidLoad()
    
    }
    
    func test_did_press_the_current_location_button() {
        
        
    }

    
    
    func test_did_search_for_city_does_nothing_when_cityString_is_empty() {
        
        
        
        
        let sut = makeSUT()
        sut.didSearchForCity(withName: "1frefre")
    
    }
    
    
    
    
    
    
    
    
    private func makeSUT() -> WeatherInteractor {
        let locationManager = CoreLocationLocationManagerStub()
        let apiManager = URLSessionWeatherApiManagerStub()
        let presenter = WeatherPresenterStub()
        return WeatherInteractor(locationManager: locationManager, apiManager: apiManager, presenter: presenter)
        
    }

    
    private class CoreLocationLocationManagerStub: LocationManager {
        var callCount = 0
        func requestLocation(completion: @escaping LocationCompletionBlock) {
            callCount += 1
        }
    }

//    private class URLSessionWeatherApiManagerStub: WeatherAPIManager {
//
//        func fetchWeatherData(for cityName: String, completion: @escaping WeatherAPICompletionBlock) {}
//        func fetchWeatherData(for location: Location, completion: @escaping WeatherAPICompletionBlock) {}
//    }

    private class WeatherPresenterStub: WeatherPresenterProtocol {
        func presentError(_ error: LocalizedError) {}
        func presentWeatherData(model: WeatherModel) {}
        func provideFeedbackForTappingCurrentLocationButton() {}
        func provideFeedbackForSearchRequest() {}
    }
}









private class URLSessionWeatherApiManagerStub: WeatherAPIManager {
    

    func fetchWeatherData(for cityName: String, completion: @escaping WeatherAPICompletionBlock) {
        
        
        
    }
    
    
    func fetchWeatherData(for location: Location, completion: @escaping WeatherAPICompletionBlock) {

        
    }
}


