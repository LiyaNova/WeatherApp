//
//  NetworkManager.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(task: NetworkTask, expecting: T.Type, completion: @escaping (Result<T?, NetworkErrors>) -> ())
}

enum Endpoints: String {
    case Main       = "MainScreenData"
    case Users      = "Users"
    case Shelters   = "ShaltersCollection"
    case petCards   = "PetCards"
}

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkErrors: String, Error {
    case invalidURL   = "URL is invalid"
    case requestError   = "Request finished with error"
    case invalidData  = "Data is nil or invalid"
    case decodingError  = "Decoding response failed"
}

struct NetworkTask {
    let endpoint: Endpoints
    let method: HTTPMethod
    let params: [String:Any]?
    
    init(_ endpoint: Endpoints,
         _ method: HTTPMethod = .get,
         _ params: [String : Any]? = nil) {
        self.endpoint = endpoint
        self.method = method
        self.params = params
    }
}

