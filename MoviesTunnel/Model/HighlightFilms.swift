//
//  HighlightFilms.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import Foundation

struct HighlightFilms {
  var popular: [Film]
  var latest: [Film]
  var upcoming: [Film]
  var topRated: [Film]
  
  init() {
    self.popular = []
    self.latest = []
    self.upcoming = []
    self.topRated = []
  }
}
