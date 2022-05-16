//
//  SimpleWeatherTests.swift
//  SimpleWeatherTests
//
//  Created by Szymon Tadrzak on 08/04/2022.
//

import XCTest
@testable import SimpleWeather

class SimpleWeatherTests: XCTestCase {

    func test_canInit() throws {
        _ = try makeSUT()
    }
    
    func test_activityIndicator_initial_state() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.activityIndicator)
    }
    
    func test_viewDidLoad_configure_locationManager() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.locationManager.delegate, "locationManager delegate")
    }
    func test_viewDidLoad_configure_searchTextField() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.searchTextField.delegate, "searchTextField delegate")
    }
    
    func test_renders_weather_from_API() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        let exp = expectation(description: "Wait for API")
        exp.isInverted = true
        wait(for: [exp], timeout: 2)
        XCTAssertEqual(sut.cityLabel.text, "San Francisco")
    }
    
    
    private func makeSUT() throws -> WeatherViewController {
        let bundle = Bundle(for: WeatherViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let initialVC = storyboard.instantiateInitialViewController()
        return try XCTUnwrap(initialVC as? WeatherViewController)
    }
}
