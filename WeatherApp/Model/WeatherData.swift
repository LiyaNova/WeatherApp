//
//  WeatherData.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//


import Foundation

struct WeatherData: Codable {
    let name: String
    let weather: [Weather]
    let coord: Coordinate
    let main: Main
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let icon: String?
}

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}

