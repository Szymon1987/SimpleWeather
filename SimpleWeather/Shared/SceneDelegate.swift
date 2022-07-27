//
//  SceneDelegate.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 05/04/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        
        
        let weatherVC = WeatherSceneBuilder.build()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = weatherVC
        window?.makeKeyAndVisible()
    }
}

