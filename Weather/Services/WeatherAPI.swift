import Foundation

struct WeatherAPI {
    private let apiKey = "YOUR_API_KEY"    //<-- ADD API HERE FROM OPENWEATHER
    
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherModel {
          guard let url = URL(string:
              "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
          ) else {
              throw WeatherError.invalidURL
          }
          
          let (data, response) = try await URLSession.shared.data(from: url)
          
          guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
              throw WeatherError.requestFailed
          }
          
          let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
          
          // Tworzymy WeatherModel
          let weatherModel = WeatherModel(
              city: decodedResponse.name,
              temperature: decodedResponse.main.temp,
              condition: decodedResponse.weather.first?.toWeatherCondition() ?? .sunny,
              humidity: decodedResponse.main.humidity,
              windSpeed: decodedResponse.wind.speed
          )
          
          return weatherModel
      }
  }

  // MARK: - Modele do dekodowania JSON
  struct WeatherResponse: Decodable {
      let name: String
      let main: Main
      let weather: [WeatherInfo]
      let wind: Wind
  }

  struct Main: Decodable {
      let temp: Double
      let humidity: Int
  }

  struct Wind: Decodable {
      let speed: Double
  }

  struct WeatherInfo: Decodable {
      let main: String
      let description: String
      
      func toWeatherCondition() -> WeatherCondition {
          switch main.lowercased() {
          case "clouds":
              return .cloudy
          case "rain", "drizzle":
              return .rainy
          case "thunderstorm":
              return .storm
          case "snow":
              return .snow
          case "clear":
              return .sunny
          default:
              return .sunny
          }
      }
  }

  enum WeatherError: Error {
      case invalidURL
      case requestFailed
  }
