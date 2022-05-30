//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 05/04/2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private var service: WeatherService!

    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        notificationForKeyboard()
        activityIndicator.isHidden = true
        setupBindings()
        service.fetchWeather()
    }
    
    private func setupBindings() {
        service.weatherServiceResponse = { [weak self] result in
            switch result {
            case .success(let weather):
                self?.updateUI(with: weather)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showErrorAlert(error)
                }
            }
        }
    }
    
    private func updateUI(with weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text = weather.temperatureString
            self.weatherImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.celciusLabel.text = "°C"
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }

    @IBAction func locationButtonTapped(_ sender: UIButton) {
        Haptics.playLightImpact()
        service.fetchWeather()
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
    
    private func showErrorAlert(_ error: WeatherError) {
        let ac = UIAlertController(title: error.rawValue, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(ac, animated: true)
    }
    
    private func showAlert(title: String) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(ac, animated: true)
    }
}

// MARK: - UITextfield Delegate Methods

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        Haptics.playLightImpact()
        searchTextField.endEditing(true)
        
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
            service.fetchWeather(for: trimmedCityName)
        }
        searchTextField.text = ""
    }
}

extension WeatherViewController {
    static func make(service: WeatherService) -> WeatherViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        return sb.instantiateViewController(identifier: "WeatherViewController") {
            let vc = WeatherViewController(coder: $0)
            vc?.service = service
            return vc
        }
    }
}

