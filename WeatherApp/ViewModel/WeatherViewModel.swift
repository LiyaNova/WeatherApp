//
//  WeatherViewModel.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//
    
import Foundation

protocol AppViewModelProtocol: AnyObject { }

final class WeatherViewModel: AppViewModelProtocol {
    let weatherFetcher: NetworkManagerProtocol
    let locationManager: LocationManager
    
    init(fetcher: NetworkManagerProtocol, locationManager: LocationManager) {
        weatherFetcher = fetcher
        self.locationManager = locationManager
    }
}
