//
//  WeatherCondition+UI.swift
//  Weather
//
//  Created by Sebastian Brzeziński on 19/03/2025.
//

import SwiftUI

extension WeatherCondition {
  
    func backgroundGradient() -> LinearGradient {
        switch self {
        case .sunny:
            return LinearGradient(
                colors: [Color("SunnyTop"), Color("SunnyBottom")],
                startPoint: .top, endPoint: .bottom
            )
            
        case .cloudy:
            return LinearGradient(
                colors: [Color("CloudyTop"), Color("CloudyBottom")],
                startPoint: .top, endPoint: .bottom
            )
            
        case .rainy:
            return LinearGradient(
                colors: [Color("RainyTop"), Color("RainyBottom")],
                startPoint: .top, endPoint: .bottom
            )
            
        case .snow:
  
            return LinearGradient(
                colors: [Color("CloudyTop"), Color("CloudyBottom")],
                startPoint: .top, endPoint: .bottom
            )
            
        case .storm:
        
            return LinearGradient(
                colors: [Color("RainyTop"), Color("RainyBottom")],
                startPoint: .top, endPoint: .bottom
            )
        }
    }
}
