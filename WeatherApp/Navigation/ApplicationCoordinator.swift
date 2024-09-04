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
    private let alertManager = AlertManager()
  
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewModel = WeatherViewModel(fetcher: WeatherFetcher())
        mainViewController = WeatherViewController(viewModel: viewModel)
      
        window.rootViewController = mainViewController
        window.makeKeyAndVisible()
    }
}
