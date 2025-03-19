//
//  WeatherModel.swift
//  Weather
//
//  Created by Sebastian Brzeziński on 19/03/2025.
//
import Foundation

struct WeatherModel {
    let city: String
    let temperature: Double
    let condition: WeatherCondition
    let humidity: Int      
    let windSpeed: Double
}

enum WeatherCondition {
    case sunny
    case cloudy
    case rainy
    case snow
    case storm
    
    var sfSymbol: String {
        switch self {
        case .sunny:
            return "sun.max.fill"
        case .cloudy:
            return "cloud.fill"
        case .rainy:
            return "cloud.rain.fill"
        case .snow:
            return "cloud.snow.fill"
        case .storm:
            return "cloud.bolt.rain.fill"
        }
    }
    
    var description: String {
        switch self {
        case .sunny:
            return "Sunny"
        case .cloudy:
            return "Cloudy"
        case .rainy:
            return "Rainy"
        case .snow:
            return "Snow"
        case .storm:
            return "Storm"
        }
    }
}
