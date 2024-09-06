//
//  WeatherAppWidgetEntryView.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 05.09.2024
//
    

import WidgetKit
import SwiftUI

struct WeatherAppWidgetEntryView : View {
    var entry: WeatherAppWidgetProvider.Entry

    var body: some View {
        VStack {
            Text(entry.weatherModel.temperatureString)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text(entry.weatherModel.cityName)
                .font(.largeTitle)
                .fontWeight(.medium)
        }
        .containerBackground(for: .widget) { Color.yellow }
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let entry = WeatherAppWidgetProvider.Entry(date: Date(), weatherModel: WeatherModel(cityName: "Chicago", temperature: 83.2, icon: nil))
        WeatherAppWidgetEntryView(entry: entry)
    }
}

