//
//  AlertManager.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//
    
import UIKit

protocol AlertManagerProtocol: AnyObject {
    func showAlert(ofType type: AlertType, on viewController: UIViewController?)
}

enum AlertType {
    case networkIssue(String)
    case locationUnavailable
}

class AlertManager: AlertManagerProtocol {
    func showAlert(ofType type: AlertType, on viewController: UIViewController?) {
        let alert: UIAlertController
        
        switch type {
        case .networkIssue(let text):
            alert = createNetworkIssueAlert(text)
        case .locationUnavailable:
            alert = locationUnavailableAlert()
        }

        DispatchQueue.main.async { 
            viewController?.present(alert, animated: true)
        }
    }
}

//MARK: - AlertManager extension
private extension AlertManager {
    func createNetworkIssueAlert(_ fieldText: String) -> UIAlertController {
        let alert = UIAlertController(title: "", message: fieldText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
    
    func locationUnavailableAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Sorry", message: "We need your location to get the current weather. Change your settings, please", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
}
