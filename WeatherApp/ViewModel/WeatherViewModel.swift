//
//  WeatherViewModel.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//

import Foundation

protocol AppViewModelProtocol: AnyObject { 
    var updateWeatherByCity: ((WeatherModel) -> ())? { get set }
    var onNavigationEvent: ((NavigationEvent) -> ())? { get set }
    
    func getWeather()
    func getWeatherByCity(_ name: String)
    func tapForLocalWeather()
}

final class WeatherViewModel: AppViewModelProtocol {
    var onNavigationEvent: ((NavigationEvent) -> ())?
    var updateWeatherByCity: ((WeatherModel) -> ())?
    
    private var locationLon: Double?
    private var locationLat: Double?
    
    private var locationAvailable: Bool {
        locationManager.status != .denied && locationManager.status != .restricted
    }
    
    private var savedCityName: String? {
        UserDefaults.standard.string(forKey: "cityName")
    }
    
    private let locationManager = LocationManager.shared
    private let weatherFetcher: NetworkManagerProtocol
    
    init(fetcher: NetworkManagerProtocol) {
        self.weatherFetcher = fetcher
    }
    
    func getWeather() {
        locationManager.locationManagerDelegate = self
        
        if !locationAvailable, let savedCityName {
            getWeatherByCity(savedCityName)
        }
    }
    
    func getWeatherByCity(_ name: String) {
        weatherFetcher.fetchData(type: WeatherData.self, url: .cityName(name: name)) { [weak self] result in
            switch result {
            case .success(let data):
                self?.processData(for: data)
            case .failure(let error):
                self?.onNavigationEvent?(.networkAlert(error.description))
            }
        }
    }
    
    func tapForLocalWeather() {
        locationAvailable ? getWeatherByLocation() : onNavigationEvent?(.locationAlert)
     }
    
    private func getWeatherByLocation() {
        guard let locationLat, let locationLon else { return }
        
        weatherFetcher.fetchData(type: WeatherData.self, url: .userLocation(lon: locationLat, lat: locationLon)) { [weak self] result in
            switch result {
            case .success(let data):
                self?.processData(for: data)
            case .failure(let error):
                self?.onNavigationEvent?(.networkAlert(error.description))
            }
        }
    }
    
    private func processData(for data: WeatherData) {
        UserDefaults.standard.set(data.name, forKey: "cityName")
        
        let iconName = data.weather.first?.icon
        let image = weatherFetcher.getImage(for: iconName)
        let model = WeatherModel(cityName: data.name, temperature: data.main.temp, icon: image)
        
        updateWeatherByCity?(model)
    }
}

extension WeatherViewModel: LocationManagerDelegate {
    func useUserLocation(latitude: Double?, longitude: Double?) {
        locationLat = latitude
        locationLon = longitude
        
        savedCityName != nil ? getWeatherByCity(savedCityName!) : getWeatherByLocation()
    }
}
