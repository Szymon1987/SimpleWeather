//
//  MainQueueDispatchDecorator.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 22/05/2022.
//

import Foundation


final class MainQueueDispatchDecorator: WeatherService {
    func fetchWeather(for cityName: String) {}
    func fetchWeather() {}
    
    
    var completion: ((Result<WeatherModel, WeatherError>) -> Void)?
    private var decoratee: WeatherService
    
    init(_ decoratee: WeatherService) {
        self.decoratee = decoratee
        setupBindings()
    }
    
    
    func setupBindings() {
        decoratee.completion = { result in
            self.guaranteeMainThread {
                self.completion?(result)
            }
        }
    }

    func guaranteeMainThread(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
    

}
