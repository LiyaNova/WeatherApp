//
//  WeatherAppWidgetEntry.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 05.09.2024
//
    
import WidgetKit
import SwiftUI

struct WeatherAppWidgetEntry: TimelineEntry {
    let date: Date
    let weatherModel: WeatherModel
}
