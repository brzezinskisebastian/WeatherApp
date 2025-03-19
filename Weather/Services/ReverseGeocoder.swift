//
//  ReverseGeocoder.swift
//  Weather
//
//  Created by Sebastian Brzeziński on 19/03/2025.
//

import CoreLocation

class ReverseGeocoder {
    private let geocoder = CLGeocoder()
    
  
    func reverseGeocode(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocode error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }
            
            // Możesz wybrać locality (miasto) lub subLocality (dzielnica)
            if let city = placemark.locality {
                completion(city)
            } else {
                completion(nil)
            }
        }
    }
}
