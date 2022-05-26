//
//  NetworkService.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 26/05/2022.
//

import Foundation


// make it generic with extension probably

class NetworkService {
    
    public func performRequest(for endpoint: String, completion: @escaping (Result<WeatherModel, WeatherError>) -> Void) {
        
        guard let url = URL(string: endpoint) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidCityName))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decodedWeatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                let name = decodedWeatherData.name
                let temp = decodedWeatherData.main.temp
                let id = decodedWeatherData.weather[0].id
                
                let weatherModel = WeatherModel(cityName: name, temperature: temp, conditionId: id)
                completion(.success(weatherModel))
            } catch {
                completion(.failure(.invalidData))
            }
            
            
        }
        task.resume()
    }
}
