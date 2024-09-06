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
        searchTextField.backgroundColor = .white
        searchTextField.placeholder = "Type city name"
        
        return searchTextField
    }()
    
    private let locationBtn: UIButton = {
        let locationBtn = UIButton()
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
        tempStack.spacing = 10
        
        return tempStack
    }()
    
    private let cityLbl: UILabel = {
        let cityLbl = UILabel()
        cityLbl.translatesAutoresizingMaskIntoConstraints = false
        cityLbl.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        cityLbl.textAlignment = .center
        
        return cityLbl
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
        
        viewModel.getWeather()
        bindUpdates()
    }
    
    private func bindUpdates() {
        viewModel.updateWeatherByCity = { [weak self] model in
            DispatchQueue.main.async {
                self?.tempLbl.text = model.temperatureString
                self?.cityLbl.text = model.cityName
                
                guard let icon = model.icon else { return }
                self?.tempImg.image = UIImage(data: icon)
            }
        }
    }
    
    @objc private func getLocalWeatherIfAvailable() {
        viewModel.tapForLocalWeather()
    }
    
    private func setupUI() {
        view.backgroundColor = .lightGray
        searchTextField.delegate = self
        locationBtn.addTarget(self, action: #selector(getLocalWeatherIfAvailable), for: .touchUpInside)
        
        searchStack.addArrangedSubview(locationBtn)
        searchStack.addArrangedSubview(searchTextField)
        tempStack.addArrangedSubview(tempLbl)
        tempStack.addArrangedSubview(tempImg)
        view.addSubview(searchStack)
        view.addSubview(tempStack)
        view.addSubview(cityLbl)
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
            tempStack.topAnchor.constraint(equalTo: searchStack.bottomAnchor, constant: 10),
            cityLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            cityLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            cityLbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let city = searchTextField.text else { return }
        
        viewModel.getWeatherByCity(city)
        searchTextField.text = ""
    }
}
