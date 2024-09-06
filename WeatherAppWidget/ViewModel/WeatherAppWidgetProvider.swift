//
//  WeatherAppWidgetProvider.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 05.09.2024
//
    
import WidgetKit
import SwiftUI

struct WeatherAppWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherAppWidgetEntry {
        WeatherAppWidgetEntry(date: Date(), weatherModel: WeatherModel(cityName: "Chicago", temperature: 83, icon: nil))
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherAppWidgetEntry) -> ()) {
        createSnapshotEntry(date: Date(), completion: completion)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        createEntryTimeline(date: Date(), completion: completion)
    }
    
    //MARK: - FetchData
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    private func createSnapshotEntry(date: Date, completion:  @escaping (WeatherAppWidgetEntry) -> ()) {
        getWeather { model in
            let entry = WeatherAppWidgetEntry(date: date, weatherModel: model)
            completion(entry)
        }
    }
    
    private func createEntryTimeline(date: Date, completion: @escaping (Timeline<WeatherAppWidgetEntry>) -> ()) {
        getWeather { model in
            var entries = [WeatherAppWidgetEntry]()
            
            for dayOffset in 0..<7 {
                let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: Date())!
                let startOfDate = Calendar.current.startOfDay(for: entryDate)
                let entry = WeatherAppWidgetEntry(date: startOfDate, weatherModel: model)
                entries.append(entry)
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
    
    private func getWeather(completion:  @escaping (WeatherModel) -> ()) {
        let name = UserDefaults.standard.string(forKey: "cityName")
        
        networkManager.fetchData(type: WeatherData.self, url: .cityName(name: name ?? "Chicago")) { result in
            switch result {
            case .success(let data):
                let model = WeatherModel(cityName: data.name, temperature: data.main.temp, icon: nil)
                completion(model)
            case .failure(let error):
                print(error.description)
            }
        }
    }
}


