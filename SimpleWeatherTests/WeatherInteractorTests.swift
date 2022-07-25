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
        let locationMansger = CoreLocationLocationManagerStub()
        let sut = WeatherInteractor(locationManager: locationMansger, apiManager: URLSessionWeatherApiManagerStub(), presenter: WeatherPresenterStub())
        
        sut.viewDidLoad()
        
        XCTAssertEqual(locationMansger.callCount, 1)
    }
    
    func test_did_press_the_current_location_button() {
        
    }

    
    
    func test_did_search_for_city_does_nothing_when_cityString_is_empty() {
        
        let locMan = CoreLocationLocationManagerStub()
        let apiMan = URLSessionWeatherApiManagerStub()
        let presenter = WeatherPresenterStub()
        let sut = WeatherInteractor(locationManager: locMan, apiManager: apiMan, presenter: presenter)
        
        sut.didSearchForCity(withName: "")
        XCTAssertEqual(apiMan.fetchWeatherDataForCiryCallCount, 0)
    }
    
    func test_did_search_for_city_calls_ApiManager_when_string_is_not_empty() {
        
        let locMan = CoreLocationLocationManagerStub()
        let apiMan = URLSessionWeatherApiManagerStub()
        let presenter = WeatherPresenterStub()
        let sut = WeatherInteractor(locationManager: locMan, apiManager: apiMan, presenter: presenter)
        
        sut.didSearchForCity(withName: "cityName")
        XCTAssertEqual(apiMan.fetchWeatherDataForCiryCallCount, 1)
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
    


    private class WeatherPresenterStub: WeatherPresenterProtocol {
        func presentError(_ error: LocalizedError) {}
        func presentWeatherData(model: WeatherModel) {}
        func provideFeedbackForTappingCurrentLocationButton() {}
        func provideFeedbackForSearchRequest() {}
    }
}


private class URLSessionWeatherApiManagerStub: WeatherAPIManager {
    
    var fetchWeatherDataForCiryCallCount = 0
    
    func fetchWeatherData(for cityName: String, completion: @escaping WeatherAPICompletionBlock) {
        fetchWeatherDataForCiryCallCount += 1
    }
    
    
    func fetchWeatherData(for location: Location, completion: @escaping WeatherAPICompletionBlock) {
        
    }
}


