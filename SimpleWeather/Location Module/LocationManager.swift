//
//  LocationManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 10/06/2022.
//

import Foundation

protocol LocationManager {
    typealias LocationCompletionBlock = (Result<Location, LocationError>) -> Void
    func requestLocation(completion: @escaping LocationCompletionBlock)
}
