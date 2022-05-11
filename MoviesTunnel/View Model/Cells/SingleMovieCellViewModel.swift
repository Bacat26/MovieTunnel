//
//  SingleMovieCellViewModel.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import Foundation

protocol SingleMovieCellViewModelable {
  var movieId: Int { get }
  var posterURL: URL? { get }
  var isPlaceHolder: Bool { get }
}

class SingleMovieCellViewModel: SingleMovieCellViewModelable {
  
  var movieId: Int
  var posterURL: URL?
  var isPlaceHolder: Bool
  
  init(movie: Movie?, isPlaceholder: Bool = false) {
    self.posterURL = movie?.posterURL
    self.movieId = movie?.id ?? 0
    self.isPlaceHolder = isPlaceholder
  }
}
