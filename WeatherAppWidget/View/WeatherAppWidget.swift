//
//  WeatherAppWidget.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 05.09.2024
//
    

import WidgetKit
import SwiftUI

struct WeatherAppWidget: Widget {
    let kind: String = "WeatherAppWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeatherAppWidgetProvider()) { entry in
            if #available(iOS 17.0, *) {
                WeatherAppWidgetEntryView(entry: entry)
                    .containerBackground(.background, for: .widget)
            } else {
                WeatherAppWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("WeatherAppWidget")
        .description("This is WeatherAppWidget.")
        .supportedFamilies(families)
    }
    
    var families: [WidgetFamily] {
        if #available(iOSApplicationExtension 16.0, watchOS 9.0, *) {
            return [.accessoryCircular, .accessoryInline, .systemSmall]
        } else {
            return [.systemSmall]
        }
    }
}
