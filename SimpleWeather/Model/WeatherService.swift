//
//  WeatherManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 06/04/2022.
//

import UIKit
import CoreLocation

protocol WeatherServiceDelegate {
    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel)
    func didFailWithError(error: Error)
    func didShowActivityIndicator()
}

struct WeatherService {
    
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=aa4a676216f9b5dc4ff27c58beff9360&units=metric"
    
    var delegate: WeatherServiceDelegate?
    
    func fetchWeather(for cityName: String) {
        let urlString = "\(url)&q=\(cityName)"
        performRequest(for: urlString)
    }

    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(url)&lat=\(latitude)&lon=\(longitude)"
        performRequest(for: urlString)
    }
    
    func performRequest(for urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                }
                if let data = data {
                    if let weather = parseJSON(with: data) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        self.delegate?.didShowActivityIndicator()
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(with data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedWeatherData = try decoder.decode(WeatherData.self, from: data)
            let name = decodedWeatherData.name
            let temp = decodedWeatherData.main.temp
            let id = decodedWeatherData.weather[0].id
            let weaterModel = WeatherModel(cityName: name, temperature: temp, conditionId: id)
            return weaterModel
        } catch {
            print(error)
        }
        return nil
    }
}
