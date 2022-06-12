//
//  URLSessionWeatherAPIManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 11/06/2022.
//

import Foundation

class URLSessionWeatherAPIManager {
    private let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
}

//MARK: - WeatherAPIManager Protocol Methods
extension URLSessionWeatherAPIManager: WeatherAPIManager {
    func fetchWeatherData(for cityName: String, completion: @escaping (Result<WeatherModel, WeatherAPIError>) -> Void) {
        let endpointURLString = "\(urlString)&q=\(cityName)"
        performRequest(for: endpointURLString, errorType: .invalidCityName, completion: completion)
    }
    
    func fetchWeatherData(for location: Location, completion: @escaping (Result<WeatherModel, WeatherAPIError>) -> Void) {
        let endpointURLString = "\(self.urlString)&lat=\(location.latitude)&lon=\(location.longitude)"
        performRequest(for: endpointURLString, errorType: .invalidLocation, completion: completion)
    }
    
    //MARK: - Private Methods
    private func performRequest(for endpointURL: URL, completion: @escaping (Result<WeatherModel, WeatherAPIError>) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: endpointURL) { [weak self] data, response, error in
            if let self = self {
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
                completion(self.parseJSON(with: data))
            }
        }
        task.resume()
    }
    
    private func parseJSON(with data: Data) -> (Result<WeatherModel, WeatherAPIError>) {
        let decoder = JSONDecoder()
        do {
            let decodedWeatherData = try decoder.decode(WeatherData.self, from: data)
            return .success(decodedWeatherData.weatherModel)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    //MARK: - Helpers
    private func performRequest(for urlString: String, errorType: WeatherAPIError, completion: @escaping (Result<WeatherModel, WeatherAPIError>) -> Void) {
        if let url = URL(string: urlString) {
            performRequest(for: url,completion: completion)
        } else {
            completion(.failure(errorType))
        }
    }
}
