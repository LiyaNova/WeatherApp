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
    
    func getUserLocation()
    func getWeatherByLocation()
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
    
    private let weatherFetcher: NetworkManagerProtocol
    private let locationManager = LocationManager.shared
    
    init(fetcher: NetworkManagerProtocol) {
        self.weatherFetcher = fetcher
    }
    
    func getUserLocation() {
        locationManager.locationManagerDelegate = self
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
    
    func getWeatherByLocation() {
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
    
    func tapForLocalWeather() {
        locationAvailable ? getWeatherByLocation() : onNavigationEvent?(.locationAlert)
     }
    
    private func processData(for data: WeatherData) {
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
        
        getWeatherByLocation()
    }
}
