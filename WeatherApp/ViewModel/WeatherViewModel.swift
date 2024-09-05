//
//  WeatherViewModel.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//

import Foundation

protocol AppViewModelProtocol: AnyObject { 
    func getUserLocation()
    func getWeatherByCity(_ name: String)
}

final class WeatherViewModel: AppViewModelProtocol {
    private let weatherFetcher: NetworkManagerProtocol
    private let locationManager = LocationManager.shared
    
    private var locationLon: Double?
    private var locationLat: Double?
    
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
                let model = WeatherModel(cityName: data.name, temperature: data.main.temp, icon: data.weather.first?.icon)
                self?.getImage(for: model.icon)
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getWeatherByLocation() {
        guard let locationLat, let locationLon else { return }
        
        weatherFetcher.fetchData(type: WeatherData.self, url: .userLocation(lon: locationLat, lat: locationLon)) { [weak self] result in
            switch result {
            case .success(let data):
                let model = WeatherModel(cityName: data.name, temperature: data.main.temp, icon: data.weather.first?.icon)
                self?.getImage(for: model.icon)
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getImage(for name: String?) {
        guard let name else { return }
        let image = weatherFetcher.getImage(for: name)
        print(image)
    }
}

extension WeatherViewModel: LocationManagerDelegate {
    func useUserLocation(latitude: Double?, longitude: Double?) {
        locationLat = latitude
        locationLon = longitude
        
        getWeatherByLocation()
    }
    
    func askAgainLocationPermission() {
        //TODO
    }
}
