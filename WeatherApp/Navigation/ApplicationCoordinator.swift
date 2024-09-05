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
    private var mainViewModel: AppViewModelProtocol?
    private var alertManager: AlertManagerProtocol?
  
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let mainViewModel = WeatherViewModel(fetcher: NetworkManager())
        self.mainViewModel = mainViewModel
        mainViewController = WeatherViewController(viewModel: mainViewModel)
        alertManager = AlertManager()
      
        window.rootViewController = mainViewController
        window.makeKeyAndVisible()
        
        bindNavigationEvents()
    }
    
    private func bindNavigationEvents() {
        mainViewModel?.onNavigationEvent = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .locationAlert:
                alertManager?.showAlert(ofType: .locationUnavailable, on: mainViewController)
            case .networkAlert(let text):
                alertManager?.showAlert(ofType: .networkIssue(text), on: mainViewController)
            }
        }        
    }
}
