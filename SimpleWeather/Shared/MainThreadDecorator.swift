//
//  MainThreadDecorator.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 16/06/2022.
//

import Foundation

// NOTICE: MainThreadDecorator implemented only for practice purposes

final class MainThreadDecorator: WeatherAPIManager {
    
    private let decoratee: WeatherAPIManager
    
    init(_ decoratee: WeatherAPIManager) {
        self.decoratee = decoratee
    }
    
    func fetchWeatherData(for cityName: String, completion: @escaping WeatherAPICompletionBlock) {
        decoratee.fetchWeatherData(for: cityName) { [weak self] result in
            self?.guaranteeMainThread {
                completion(result)
            }
        }
    }
    
    func fetchWeatherData(for location: Location, completion: @escaping WeatherAPICompletionBlock) {
        decoratee.fetchWeatherData(for: location) { [weak self] result in
            self?.guaranteeMainThread {
                completion(result)
            }
        }
    }
    
    private func guaranteeMainThread(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}


func guaranteeMaintthreae(_ work: @escaping () -> Void) {
    if Thread.isMainThread {
        work()
    } else {
        DispatchQueue.main.async(execute: work)
    }
}
