//
//  NetworkError.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//
    
import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case invalidURL
    case requestError
    case urlError
    case parsingError

    var description: String {
        switch self {
        case .invalidURL, .parsingError, .urlError:
            return "Sorry, something went wrong. Please, try again later"
        case .requestError:
            return "Sorry, the connection to our server failed. Please, try again later"
        }
    }
}

