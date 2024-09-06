//
//  MockNetworkManager.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 05.09.2024
//

import Foundation
@testable import WeatherApp

class MockNetworkManager: NetworkManagerProtocol {
    var isFetchDataMethodCalled = false
    
    func fetchData<T>(type: T.Type, url: WeatherApp.Endpoint, completion: @escaping (Result<T, WeatherApp.NetworkError>) -> Void) where T : Decodable {
        isFetchDataMethodCalled = true
    }
    
    func getImage(for name: String?) -> Data? {
        return nil
    }
}
