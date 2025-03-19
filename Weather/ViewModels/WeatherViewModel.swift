//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Sebastian Brzeziński on 19/03/2025.
//
import SwiftUI
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var weather: WeatherModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let weatherAPI = WeatherAPI()
    private let locationManager = LocationManager()
    private let reverseGeocoder = ReverseGeocoder()
    
    init() {
        observeLocationChanges()
    }
    
    private func observeLocationChanges() {
        Task {
            while true {
                if let coordinate = locationManager.currentLocation {
                    // 1) Pobierz nazwę miasta
                    reverseGeocode(coordinate: coordinate)
                    // 2) Pobierz pogodę
                    await fetchWeather(lat: coordinate.latitude, lon: coordinate.longitude)
                    break
                }
                try? await Task.sleep(nanoseconds: 500_000_000)
            }
        }
    }
    
    /// Wywołanie ReverseGeocoder
    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
        reverseGeocoder.reverseGeocode(latitude: coordinate.latitude,
                                       longitude: coordinate.longitude) { [weak self] city in
            guard let self = self else { return }
            Task { @MainActor in
                self.cityName = city ?? "Unknown"
               
            }
        }
    }
    
    func fetchWeather(lat: Double, lon: Double) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedWeather = try await weatherAPI.fetchWeather(lat: lat, lon: lon)
            // Ustawiamy city z self.cityName
            self.weather = WeatherModel(
                city: self.cityName,
                temperature: fetchedWeather.temperature,
                condition: fetchedWeather.condition,
                humidity: fetchedWeather.humidity,  
                windSpeed: fetchedWeather.windSpeed
            
            )
        } catch {
            self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func refreshLocation() {
        locationManager.startUpdatingLocation()
    }
}
