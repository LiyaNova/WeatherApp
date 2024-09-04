//
//  ApplicationCoordinator.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//
    
import UIKit

final class ApplicationCoordinator: CoordinatorProtocol {
    private let window: UIWindow
    private var mainViewController: UIViewController?
    private var alertManager: AlertManagerProtocol?
  
    init(window: UIWindow, alertManager: AlertManagerProtocol? = AlertManager()) {
        self.window = window
    }
    
    func start() {
        let viewModel = WeatherViewModel(fetcher: WeatherFetcher(), locationManager: LocationManager())
        mainViewController = WeatherViewController(viewModel: viewModel)
      
        window.rootViewController = mainViewController
        window.makeKeyAndVisible()
    }
}
