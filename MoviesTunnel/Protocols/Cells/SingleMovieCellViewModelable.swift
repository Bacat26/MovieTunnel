//
//  SingleMovieCellViewModelable.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import Foundation

protocol SingleMovieCellViewModelable {
  var movieId: Int { get }
  var posterURL: URL? { get }
  var isPlaceHolder: Bool { get }
  var movie: Movie? { get }
}
