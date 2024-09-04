//
//  WeatherViewController.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//
    

import UIKit

class WeatherViewController: UIViewController {
    
    init(viewModel: AppViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}

