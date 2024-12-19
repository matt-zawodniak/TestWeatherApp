//
//  SearchCardView.swift
//  WeatherApp
//
//  Created by Matt Zawodniak on 12/19/24.
//

import SwiftUI

struct SearchCardView: View {
  @ObservedObject var model: ViewModel
  var body: some View {
    HStack {
      VStack {
        Text(model.searchedCity?.name ?? "Searching")
          .font(.largeTitle)
          .bold()

        Text("\(model.searchedCity?.temperature ?? 0)°")
          .font(.system(size: 72))
          .bold()
      }

      Spacer()

      AsyncImage(url: URL(string: "https:\(model.searchedCity?.condition.icon ?? "")?timestamp=\(Date().timeIntervalSince1970)")) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: 200)
      } placeholder: {
        EmptyView()
      }
    }
    .padding()
    .background {
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.gray)
        .opacity(0.2)
    }
    .frame(maxHeight: 200)
    .onChange(of: model.searchText) {
      if model.searchText != "" {
        Task {
          do {
            model.searchedCity = try await WeatherAPI().fetchCurrentCity(id: model.searchText)
          } catch Errors.invalidJSON {
            print("Invalid JSON")
          } catch Errors.invalidURL {
            print("Invalid URL")
          } catch Errors.invalidResponse {
            print("Invalid Response")
          }
          catch {
            print("Unexpected Error")
          }
        }
      }
    }
  }
}
