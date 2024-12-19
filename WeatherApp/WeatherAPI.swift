//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Matt Zawodniak on 12/18/24.
//

import Foundation

struct WeatherAPI {
  let apiKey = "" // Copy and Paste WeatherAPI Key Here
  let baseURL = "http://api.weatherapi.com/v1"

  func fetchCurrentCity(id: String) async throws -> City {
    let currentCityCall = "\(baseURL)/current.json?key=\(apiKey)&q=\(id)&aqi=no"
    print(currentCityCall)
    guard let url = URL(string: currentCityCall) else {
      throw Errors.invalidURL
    }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
      throw Errors.invalidResponse
    }

    do {
      let decoder = JSONDecoder()
      return try decoder.decode(City.self, from: data)
    } catch {
      throw Errors.invalidJSON
    }
  }
}
