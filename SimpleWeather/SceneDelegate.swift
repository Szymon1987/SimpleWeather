//
//  SceneDelegate.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 05/04/2022.
//

import UIKit
//import CoreLocation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {


    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let _ = (scene as? UIWindowScene) else { return }
//
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let locationService = LocationService()
        let urlString = WeatherServiceApiStrings.openWeatherBaseUrl + WeatherServiceApiStrings.openWeatherApiKey + WeatherServiceApiStrings.inCelcius
        let service = WeatherApiService(locatinService: locationService, urlString: urlString)

//        let location = Location()
        
        let vc = WeatherViewController.make(service: service)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()


//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateInitialViewController() as? WeatherViewController
//
//        window = UIWindow(windowScene: windowScene)
//        window?.makeKeyAndVisible()
//
//        let service = WeatherApiService()
//        let coreLocation = CLLocationManager()
//
//        window?.rootViewController = vc
//        vc?.service = service
//        vc?.locationManager = coreLocation
//
        
        
        

//        window = UIWindow(windowScene: windowScene)
//        let weatherService = WeatherApiService()
//        let coreLocation = CLLocationManager()
//        let bundle = Bundle(for: WeatherViewController.self)
//        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
//            let vc = storyboard.instantiateViewController(identifier: "Main") { (coder) -> UIViewController? in
//                return WeatherViewController(
//                    coder: coder,
//                    weatherService: weatherService,
//                    locationManager: coreLocation
//            )
//        }
//        window?.rootViewController = vc
//        window?.makeKeyAndVisible()
    }
}

