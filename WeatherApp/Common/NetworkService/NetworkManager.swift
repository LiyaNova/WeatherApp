//
//  NetworkManager.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(type: T.Type, url: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
    func getImage(for name: String?) -> Data?
}

final class NetworkManager: NetworkManagerProtocol {
    func fetchData<T>(type: T.Type, url: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        guard let url = URL(string: Endpoint.baseURL.path() + url.path()) else {
            let error = NetworkError.invalidURL
            completion(.failure(error))
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data , response, error) in
            if let error = error as? URLError {
                completion(.failure(.urlError))
            } else if  let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.requestError))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(type, from: data)
                    completion(.success(result))
                }catch {
                    completion(.failure(.parsingError))
                }
            }
        }
        task.resume()
    }
    
    func getImage(for name: String?) -> Data? {
        guard let name else { return nil }
        
        let endpoint = Endpoint.imgURL(name: name).path()
        
        guard let url = URL(string: endpoint) else { return nil }
        
        return try? Data(contentsOf: url)
    }
}
