//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Matt Zawodniak on 12/18/24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
          HomeScreen(searchText: "")
        }
    }
}
