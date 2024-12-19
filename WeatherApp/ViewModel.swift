//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Matt Zawodniak on 12/19/24.
//

import Foundation

class ViewModel: ObservableObject {
  @Published var query: String? = UserDefaults.standard.string(forKey: "currentCity")
  @Published var searching: Bool = false
  @Published var searchText: String = ""
  @Published var currentCity: City?
  @Published var searchedCity: City?

  func saveAndUpdate(city: City) {
    query = city.name
    currentCity = city
    searchText = ""
    searching = false
    UserDefaults.standard.set(query, forKey: "currentCity")
  }
}
