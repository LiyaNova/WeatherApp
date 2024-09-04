//
//  WeatherFetcher.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//
    
import Foundation

class WeatherFetcher: NetworkManagerProtocol {
    func fetchData<T>(task: NetworkTask, expecting: T.Type, completion: @escaping (Result<T?, NetworkErrors>) -> ()) where T : Decodable {
        //TOD0
    }
}
