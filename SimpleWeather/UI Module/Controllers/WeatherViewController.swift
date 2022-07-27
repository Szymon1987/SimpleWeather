//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 05/04/2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK: - IBOutlets & Properties
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var searchTextField: UITextField!
 
    var interactor: WeatherInteracting!
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        interactor.viewDidLoad()
    }
    
    //MARK: - Initialization
    private func initialSetup() {
        configureUIElements()
        configureNotifications()
    }
    
    //MARK: - Helpers
    private func configureSearchTextField() {
        searchTextField.delegate = self
        searchTextField.placeholder = "Type the city name here..."
    }
    
    private func configureUIElements() {
        configureSearchTextField()
        showSpinner()
    }
    
    private func configureNotifications() {
        notificationForKeyboard()
    }
    
    private func configureSpinnerVisibility(isHidden: Bool) {
        activityIndicator.isHidden = isHidden
    }

    
    //MARK: - IBActions
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        interactor.didPressTheCurrentLocationButton()
    }
}

//MARK: - Keyboard Notifications
extension WeatherViewController {
    private func notificationForKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(WeatherViewController.keyboardWillShow),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self, selector: #selector(WeatherViewController.keyboardWillHide),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

// MARK: - UITextfield Delegate Methods
extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        interactor.didSearchForCity(withName: searchTextField.text!)
    }
}
// MARK: - WeatherViewControllerProtocol Protocol Methods
extension WeatherViewController: WeatherViewControllerProtocol {
    func triggerLightHapticFeedback() {
        HapticFeedback.playLightImpact()
    }
    
    func showSpinner() {
            self.activityIndicator.startAnimating()
            self.configureSpinnerVisibility(isHidden: false)
    }
    
    func hideSpinner() {
            self.activityIndicator.stopAnimating()
            self.configureSpinnerVisibility(isHidden: true)
    }
    
    func updateWeatherDataInUI(with viewModel: WeatherConditionViewModel) {
            self.temperatureLabel.text = viewModel.temperature
            self.weatherImageView.image = UIImage(systemName: viewModel.weatherConditionIconName)
            self.cityLabel.text = viewModel.cityName
            self.celciusLabel.text = "°C"
    }
    
    func showErrorAlert(_ error: LocalizedError) {
            let ac = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(ac, animated: true)
    }
    
    func clearSearchTextField() {
            self.searchTextField.text = ""
    }
}
