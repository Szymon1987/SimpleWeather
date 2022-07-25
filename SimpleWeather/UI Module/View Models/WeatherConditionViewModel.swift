//
//  WeatherConditionViewModel.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 11/06/2022.
//

import Foundation
import UIKit

struct WeatherConditionViewModel {
    let cityName: String
    let temperature: String
    let weatherConditionIconName: String
    
    init(model: WeatherModel) {
        cityName = model.cityName
        temperature = String(format: "%.1f", model.temperature)
        weatherConditionIconName = WeatherConditionViewModel.iconNameForConditionID(model.conditionId)
    }
    
    //MARK: - Helpers
    static func iconNameForConditionID(_ conditionID: Int) -> String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...884:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

class Exammple: UIView {
    
    var view = UIView()
    
    private let colorCount: [UIColor: Int] = [:]
    
    func viewDidLoad() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        addSq(with: .red, at: sender.location(in: view))
    }
    
    func addSq(with color: UIColor, at point: CGPoint) {
        let view = UIView(frame: CGRect(x: point.x, y: point.y, width: 50, height: 50))
        view.backgroundColor = .red
        view.addSubview(view)
    }
    
}
