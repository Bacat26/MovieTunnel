//
//  HighlightFilms.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import Foundation

struct HighlightMovies {
  var popular: [Movie]
  var latest: [Movie]
  var upcoming: [Movie]
  var topRated: [Movie]
  
  init() {
    self.popular = []
    self.latest = []
    self.upcoming = []
    self.topRated = []
  }
}
