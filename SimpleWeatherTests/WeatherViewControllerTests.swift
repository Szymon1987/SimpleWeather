//
//  SimpleWeatherTests.swift
//  SimpleWeatherTests
//
//  Created by Szymon Tadrzak on 08/04/2022.
//

import XCTest
import CoreLocation
@testable import SimpleWeather

class WeatherViewControllerTests: XCTestCase {
    
    var service: WeatherService!
    var sut: WeatherViewController!
    
    override func setUp() {
        super.setUp()
        let service = WeatherServiceMock()
        sut = WeatherViewController.make(service: service)
    }
    
    override func tearDown() {
        service = nil
        sut = nil
        super.tearDown()
    }

    func test_canInit() throws {
        _ = try makeSUT()
    }
    
//    func test_activityIndicator_initial_state() {
//        sut.loadViewIfNeeded()
//        XCTAssertNotNil(sut.activityIndicator, "activity indicator")
//    }

    func test_viewDidLoad_configure_searchTextField() throws {
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.searchTextField.delegate, "searchTextField delegate")
    }
    
    func test_renders_weather_from_API() throws {
        sut.loadViewIfNeeded()
        
        let exp = expectation(description: "Wait for API")
        exp.isInverted = true
        wait(for: [exp], timeout: 2)
//        XCTAssertEqual(sut.cityLabel.text, "San Francisco")
    }
    
    
//    private func makeSUT() -> WeatherViewController {
//        let service = 
//        let vc = WeatherViewController.make(service: <#T##WeatherService#>)
//    }
    
    private func makeSUT() throws -> WeatherViewController {
        let bundle = Bundle(for: WeatherViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let initialVC = storyboard.instantiateInitialViewController()
        return try XCTUnwrap(initialVC as? WeatherViewController)
    }
}

class WeatherServiceMock: WeatherService {
    func fetchWeather(for cityName: String) {}
    func fetchWeatherForLocation() {}
    var completion: ((Result<WeatherModel, WeatherError>) -> Void)?
}
