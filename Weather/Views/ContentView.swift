import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            currentBackground()
                .edgesIgnoringSafeArea(.all)
                .animation(.easeInOut, value: viewModel.weather?.condition)
            
            VStack(spacing: 20) {
                if viewModel.isLoading {
                 
                    ProgressView(NSLocalizedString("FetchingWeather", comment: ""))
                        .foregroundColor(.white)
                        
                } else if let weather = viewModel.weather {
                    Spacer()
                    
                    Text(weather.city.isEmpty ? NSLocalizedString("YourLocation", comment: "") : weather.city)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                    
                 
                    Image(systemName: weather.condition.sfSymbol)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.yellow)
                    
            
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("\(Int(weather.temperature))°C")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(.white)
                        
                        let fahrenheit = weather.temperature * 9 / 5 + 32
                        Text("(\(Int(fahrenheit))°F)")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
             
                    VStack(spacing: 10) {
                    
                        Text("\(NSLocalizedString("Humidity", comment: "")): \(weather.humidity)%")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                 
                        Text("\(NSLocalizedString("Wind", comment: "")): \(String(format: "%.1f", weather.windSpeed)) m/s")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                  
                    Text(NSLocalizedString(weather.condition.description, comment: ""))
                        .font(.title2)
                        .foregroundColor(.white)
                    
         
                    Button(NSLocalizedString("Refresh", comment: "")) {
                        viewModel.refreshLocation()
                    }
                    .fontWeight(.bold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                    
                    Spacer()
                    
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
           
                    Text(NSLocalizedString("NoData", comment: ""))
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func currentBackground() -> some View {
        if let condition = viewModel.weather?.condition {
            condition.backgroundGradient()
        } else {
            WeatherCondition.sunny.backgroundGradient()
        }
    }
}
