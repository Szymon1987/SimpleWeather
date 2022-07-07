//
//  WeatherInteractorProtocol.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 10/06/2022.
//

import Foundation

protocol WeatherInteractorProtocol {
    func viewDidLoad()
    func didPressTheCurrentLocationButton()
    func didSearchForCity(withName cityName: String)
}

