//
//  SceneDelegate.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 05/04/2022.
//

import UIKit
import CoreLocation


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let locationManager = CLLocationManager()
        let locationService = LocationService(locationManager: locationManager)
        let urlString = WeatherServiceApiStrings.openWeatherBaseUrl + WeatherServiceApiStrings.openWeatherApiKey + WeatherServiceApiStrings.inCelcius
        let service = WeatherApiService(locatinService: locationService, urlString: urlString)
        let vc = WeatherViewController.make(service: service)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

