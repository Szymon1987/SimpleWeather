//
//  WeatherViewControllerTests.swift
//  SimpleWeatherTests
//
//  Created by Szymon Tadrzak on 13/06/2022.
//

import XCTest
@testable import SimpleWeather

class WeatherViewControllerTests: XCTestCase {
    
    func test_canInit() throws {
        _ = try makeSUT()
    }
    
    func test_viewDidLoad_IBOutlets_connections() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        _ = try XCTUnwrap(sut.weatherImageView, "weatherImageView is not connected")
        _ = try XCTUnwrap(sut.searchTextField, "searchTextField is not connected")
        _ = try XCTUnwrap(sut.activityIndicator, "activityIndicator is not connected")
        _ = try XCTUnwrap(sut.celciusLabel, "celciusLabel is not connected")
        _ = try XCTUnwrap(sut.cityLabel, "cityLabel is not connected")
    }
    
    func test_viewDidLoad_configureSearchTextField_delegate() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.searchTextField.delegate, "seatchTextFieldDelegate")
    }
    
    func test_viewDidLoad_configureSearchTextField_placeholder() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.searchTextField.placeholder, "searchTextFieldPlaceholder")
    }
    
    
    func test_viewDidLoad_isActivityIndicatorSpinning() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.activityIndicator.isAnimating)
    }
    
    
    // This test always passes as activityIndicator is visible before viewDidLoad() method
    func test_viewDidLoad_isActivityIndicatorHidden() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertTrue(!sut.activityIndicator.isHidden)
    }
    
    
    func test_frame_after_keyboard() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        let y = sut.view.frame.origin.y
        XCTAssertEqual(y, 0)
    }

    
    
    private func makeSUT() throws -> WeatherViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = try XCTUnwrap(storyboard.instantiateInitialViewController() as? WeatherViewController)
        let weatherAPIBaseURLString = WeatherAPIStrings.openWeatherBaseUrl + WeatherAPIStrings.openWeatherApiKey + WeatherAPIStrings.inCelcius
        let locationManager = CoreLocationLocationManager()
        let weatherAPIManager = URLSessionWeatherAPIManager(urlString: weatherAPIBaseURLString)
        let interactor = WeatherInteractor(locationManager: locationManager,
                                           apiManager: weatherAPIManager)
        vc.interactor = interactor
        return vc
    }
    
}


