//
//  WeatherModel.swift
//  Weather_API
//
//  Created by Kakha Sepashvili on 2/25/25.
//

import Foundation


struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}




enum WeatherError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case decodingError
    case invalidResponse(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL. Please try again."
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError:
            return "Failed to decode weather data."
        case .invalidResponse(let statusCode):
            return "Server error: \(statusCode). Please type correct City name."
        }
    }
}
