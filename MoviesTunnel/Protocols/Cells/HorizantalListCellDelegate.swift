//
//  HorizantalListCellDelegate.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import Foundation

protocol HorizantalListCellDelegate: NSObject {
  func showAllList(movieViewModelList: [SingleMovieCellViewModelable], listType: HighligtsMoviesType)
  func showMovieDetail(movie: Movie)
}
