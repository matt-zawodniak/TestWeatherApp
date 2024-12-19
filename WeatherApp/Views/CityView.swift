//
//  CityView.swift
//  WeatherApp
//
//  Created by Matt Zawodniak on 12/18/24.
//

import SwiftUI

struct CityView: View {
  @ObservedObject var model: ViewModel

  var body: some View {
    VStack {
      AsyncImage(url: URL(string: "https:\(model.currentCity?.condition.icon ?? "")")) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
      } placeholder: {
        EmptyView()
      }
      .frame(width: 200, height: 200)

      Text(model.currentCity?.name ?? "")
        .font(.largeTitle)
        .bold()

      Text("\(model.currentCity?.temperature ?? 0)°")
        .font(.system(size: 72))
        .bold()

      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.gray)
          .opacity(0.2)
          .frame(maxHeight: 100)
          .padding(40)
        HStack {
          VStack {
            Text("Humidity")
              .opacity(0.4)
            Text("\(model.currentCity?.humidity ?? 0)%")
              .opacity(0.6)
          }
          .padding()


          VStack {
            Text("UV")
              .opacity(0.4)
            Text("\(model.currentCity?.uvIndex ?? 0)")
              .opacity(0.6)
          }
          .padding()


          VStack {
            Text("Feels Like")
              .opacity(0.4)
            Text("\(model.currentCity?.feelsLike ?? 0)°")
              .opacity(0.6)
          }
          .padding()

        }
      }
      Spacer()
    }
  }
}
