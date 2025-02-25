//
//  WeatherViewModel.swift
//  Weather_API
//
//  Created by Kakha Sepashvili on 2/25/25.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var mainText: String = "Lets check weather"
    @Published var cityName: String  = ""
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = ""
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    
    private var myApiKey: String = "69aadee7d4e41d76919edfe23d9dd979"
    
    
    func fetchWeather() async {

            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(myApiKey)&units=metric"

            guard let url = URL(string: urlString) else {
                errorMessage = WeatherError.invalidURL.localizedDescription
                return
            }

            do {
                let (data, response) = try await URLSession.shared.data(from: url)

        
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    throw WeatherError.invalidResponse(httpResponse.statusCode)
                }

                let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                
                cityName = decodedData.name
                temperature = "\(decodedData.main.temp)°C"
                weatherDescription = decodedData.weather.first?.description ?? ""
                errorMessage = nil

            } catch let error as WeatherError {
                errorMessage = error.localizedDescription
            } catch {
                errorMessage = WeatherError.networkError(error).localizedDescription
            }
        }
}
