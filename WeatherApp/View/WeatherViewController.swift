//
//  WeatherViewController.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//


import UIKit

class WeatherViewController: UIViewController {
    
    let viewModel: AppViewModelProtocol
    
    init(viewModel: AppViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        viewModel.getUserLocation()
        
    }
    
    private func setUI() {
        view.backgroundColor = .cyan
    }
}

