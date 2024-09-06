//
//  WeatherAppWidgetBundle.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 05.09.2024
//
    
import WidgetKit
import SwiftUI

// I didn't really know what SwiftUI element add in one-screen app, so I made very base widget.
@main
struct WeatherAppWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherAppWidget()
    }
}
