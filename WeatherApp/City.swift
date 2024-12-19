//
//  City.swift
//  WeatherApp
//
//  Created by Matt Zawodniak on 12/18/24.
//

import Foundation

struct City: Codable {
  var name: String
  var temperature: Decimal
  var condition: Condition
  var humidity: Int
  var uvIndex: Decimal
  var feelsLike: Decimal

  enum CodingKeys: String, CodingKey {
    case location
    case current
  }

  enum LocationKeys: String, CodingKey {
    case name
  }

  enum CurrentKeys: String, CodingKey {
    case temperature = "temp_c"
    case condition
    case humidity
    case uvIndex = "uv"
    case feelsLike = "feelslike_c"
  }

  init(from decoder: Decoder) throws {
    // Top-level container
    let container = try decoder.container(keyedBy: CodingKeys.self)

    // Decode "location" object
    let locationContainer = try container.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
    name = try locationContainer.decode(String.self, forKey: .name)

    // Decode "current" object
    let currentContainer = try container.nestedContainer(keyedBy: CurrentKeys.self, forKey: .current)
    temperature = try currentContainer.decode(Decimal.self, forKey: .temperature)
    condition = try currentContainer.decode(Condition.self, forKey: .condition)
    humidity = try currentContainer.decode(Int.self, forKey: .humidity)
    uvIndex = try currentContainer.decode(Decimal.self, forKey: .uvIndex)
    feelsLike = try currentContainer.decode(Decimal.self, forKey: .feelsLike)
  }

  func encode(to encoder: any Encoder) throws {

  }



  struct Condition: Codable {
    var text: String
    var icon: String
    var code: Int
  }
}
