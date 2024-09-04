//
//  AlertManager.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//
    
import UIKit

protocol AlertManagerProtocol: AnyObject {
    func showAlert(ofType type: AlertType, on viewController: UIViewController)
}

enum AlertType {
    case invalidField(String)
    case invalidCredentials
    case noInternetConnection
}

class AlertManager: AlertManagerProtocol {
    func showAlert(ofType type: AlertType, on viewController: UIViewController) {
        //TODO
    }
}
