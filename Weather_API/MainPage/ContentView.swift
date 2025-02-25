//
//  ContentView.swift
//  Weather_API
//
//  Created by Kakha Sepashvili on 2/24/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            backgroundColor()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(viewModel.mainText)
                HStack {
                    Image(systemName: "magnifyingglass.circle")
                        .foregroundStyle(.gray)

                    TextField("Enter City", text: $viewModel.cityName, onCommit: {
                        Task {
                            await viewModel.fetchWeather()
                            if viewModel.errorMessage != nil {
                                viewModel.showAlert = true
                            }
                            print(viewModel.weatherDescription)
                        }
                    })
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .frame(width: 250, alignment: .center)
                .padding()
                VStack {
                    Text(viewModel.cityName)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(viewModel.temperature)
                        .font(.system(size: 40))
                        .foregroundStyle(.blue)
                        .bold()

                    Text(viewModel.weatherDescription)
                        .italic()
                        .font(.title3)
                }
                .padding()
              
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text("Error"),
                              message: Text(viewModel.errorMessage ?? "An unknown error occurred."),
                              dismissButton: .default(Text("OK")))
                    }
    }

    func backgroundColor() -> Color {
        if let temp = Double(viewModel.temperature.replacingOccurrences(of: "°C", with: "")) {
            return temp < 20 ? Color.red.opacity(0.3) : Color.blue.opacity(0.3)
        }
        return Color.gray.opacity(0.6)
    }

}






#Preview {
    ContentView()
}
