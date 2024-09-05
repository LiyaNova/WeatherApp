//
//  WeatherModel.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//
    
import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: Double
    let icon: Data?

    var temperatureString: String {
        String(format: "%.1f", temperature)
    }
}
