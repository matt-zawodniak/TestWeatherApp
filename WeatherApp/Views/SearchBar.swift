//
//  SearchBar.swift
//  WeatherApp
//
//  Created by Matt Zawodniak on 12/19/24.
//

import SwiftUI

struct SearchBar: View {
  @ObservedObject var model: ViewModel

  var body: some View {
    HStack {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .frame(height: 40)
          .foregroundStyle(.gray)
          .opacity(0.4)
        HStack {
          TextField("Search Location", text: $model.searchText)
          Image(systemName: "magnifyingglass")
        }
        .padding()
      }
      .background(.white)
    }
  }
}

#Preview {
  SearchBar(model: ViewModel())
}
