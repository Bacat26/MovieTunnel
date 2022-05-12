//
//  SingleMovieCellViewModel.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import Foundation

class SingleMovieCellViewModel: SingleMovieCellViewModelable {
  var movie: Movie?
  var movieId: Int
  var posterURL: URL?
  var isPlaceHolder: Bool
  
  init(movie: Movie?, isPlaceholder: Bool = false) {
    self.movie = movie
    self.posterURL = movie?.posterURL
    self.movieId = movie?.id ?? 0
    self.isPlaceHolder = isPlaceholder
  }
}
