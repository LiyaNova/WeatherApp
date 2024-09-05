//
//  WeatherViewController.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//


import UIKit

class WeatherViewController: UIViewController {
    
    private let searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.backgroundColor = .white
        
        return searchTextField
    }()
    
    private let locationBtn: UIButton = {
        let locationBtn = UIButton()
        locationBtn.translatesAutoresizingMaskIntoConstraints = false
        locationBtn.setImage(UIImage(systemName:"location.circle.fill"), for: .normal)
        
        return locationBtn
    }()
    
    private let tempLbl: UILabel = {
        let tempLbl = UILabel()
        tempLbl.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        tempLbl.textAlignment = .right
        
        return tempLbl
    }()
    
    private let tempImg: UIImageView = {
        let tempImg = UIImageView()
        tempImg.contentMode = .scaleAspectFill
        
        return tempImg
    }()
    
    private let searchStack: UIStackView = {
        let searchStack = UIStackView()
        searchStack.translatesAutoresizingMaskIntoConstraints = false
        searchStack.axis = .horizontal
        
        return searchStack
    }()
    
    private let tempStack: UIStackView = {
        let tempStack = UIStackView()
        tempStack.translatesAutoresizingMaskIntoConstraints = false
        tempStack.axis = .horizontal
        
        return tempStack
    }()
    
    private let viewModel: AppViewModelProtocol
    
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
        
        setupUI()
        setupConstraints()
        
        viewModel.getUserLocation()
    }
    
    private func setupUI() {
        view.backgroundColor = .lightGray
    
        searchStack.addArrangedSubview(locationBtn)
        searchStack.addArrangedSubview(searchTextField)
        tempStack.addArrangedSubview(tempLbl)
        tempStack.addArrangedSubview(tempImg)
        view.addSubview(searchStack)
        view.addSubview(tempStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            locationBtn.widthAnchor.constraint(equalToConstant: 50),
            searchTextField.heightAnchor.constraint(equalToConstant: 35),
            tempImg.widthAnchor.constraint(equalToConstant: 50),
            searchStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tempStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            tempStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            tempStack.topAnchor.constraint(equalTo: searchStack.bottomAnchor, constant: 20)
        ])
    }
}

