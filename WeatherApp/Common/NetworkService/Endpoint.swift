//
//  Endpoint.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//
    
import Foundation

enum Endpoint {
    case baseURL
    case cityName(name: String)
    case userLocation(lon: Double, lat: Double)
    case imgURL(name: String)

    func path() -> String {
        switch self {
        case .baseURL:
            return "https://api.openweathermap.org/data/2.5/weather?appid={YOUR API KEY}&units=metric"
        case .cityName(name: let cityName):
            return "&q=\(cityName)"
        case .userLocation(lon: let lon, lat: let lat):
            return "&lon=\(lon)&lat=\(lat)"
        case .imgURL(name: let name):
            return  "https://openweathermap.org/img/wn/\(name)@2x.png"
        }
    }
}
