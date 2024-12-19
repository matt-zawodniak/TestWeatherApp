//
//  ContentView.swift
//  WeatherApp
//
//  Created by Matt Zawodniak on 12/18/24.
//

import SwiftUI

struct HomeScreen: View {
  @ObservedObject var model = ViewModel()
  @State var searchText: String

  var body: some View {
    VStack {
      SearchBar(model: model)
        .padding()
      if model.searching {
        SearchCardView(model: model)
          .onTapGesture {
            if let city = model.searchedCity {
              model.saveAndUpdate(city: city)
            }
          }
          .padding()
          .frame(maxHeight: 300)
      } else {
        if model.currentCity != nil {
          CityView(model: model)
        } else {
          VStack {
            Text("No City Selected")
              .font(.largeTitle)
              .padding()
            Text("Please Search For A City")
          }
        }
      }
      Spacer()
    }
    .onChange(of: model.searchText) {
      if model.searchText != "" {
        model.searching = true
      }
    }
    .task {
      do {
        model.currentCity = try await WeatherAPI().fetchCurrentCity(id: model.query ?? "")
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

#Preview {
  HomeScreen(searchText: "Chicago")
}
