//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 05/04/2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    
    // property inection. We can't inject in the init() as we are using storyboard in the project. With init() it safer, we use "let" instead of "var" which means we can't change it later by accident which is safer EXMPLE
    
    
    // let service: Service
    
    // init(service: Service) {
    //      self.service = service
    //
    //   }
    //
    
    var weatherService: Service!
    let locationManager = CLLocationManager()
    
    
    init() {
        self.weatherService = WeatherService()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        
        locationManager.delegate = self
        searchTextField.delegate = self
//        weatherService.delegate = self
        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
        notificationForKeyboard()
        activityIndicator.isHidden = true
    }
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        if locationManager.authorizationStatus == .restricted || locationManager.authorizationStatus == .denied {
            showErrorAlert(title: "Allow 'SimpleWeather' to access yout location in the device Settings")
        } else {
        locationManager.requestLocation()
        Haptics.playLightImpact()
        }
    }
    
    private func notificationForKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(WeatherViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(WeatherViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    private func showErrorAlert(title: String, message: String? = nil) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(ac, animated: true)
    }
}

// MARK: - UITextfield Delegate Methods

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
            searchTextField.endEditing(true)
            Haptics.playLightImpact()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Type the city name here"
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = searchTextField.text {
            let trimmedCityName = cityName.trimmingCharacters(in: .whitespaces)
            weatherService.fetchWeather(for: trimmedCityName)
        }
        searchTextField.text = ""
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            activityIndicator.isHidden = false
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
            
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherService.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status {
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
            manager.requestLocation()
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            manager.requestLocation()
        case .authorized:
            print("authorized")
            manager.requestLocation()
        @unknown default:
            fatalError()
        }
    }
     
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        showErrorAlert(title: "Could not get your location, please try again")
    }
}
//MARK: - WeatherServiceDelegate
extension WeatherViewController: WeatherServiceDelegate {
  
    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text = weather.temperatureString
            self.weatherImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.celciusLabel.text = "°C"
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }

    func didFailWithError(_ weatherService: WeatherService, error: ServiceError) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            let title: String
            let message: String
            switch error {
            case .network:
                title = "No internet connection"
                message = "Please check your internet connection"
            case .json:
                title = "Please enter valid city name"
                message = ""
            }
                self.showErrorAlert(title: title, message: message)
        }
    }
}
