//
//  HorizantalListCellViewModel.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import UIKit

class HorizantalListCellViewModel: HorizantalListCellViewModelable {
  var movieList: [Movie]
  var listType: HighligtsMoviesType
  var cellSize: CGSize
  
  init(movieList: [Movie], listType: HighligtsMoviesType) {
    self.movieList = movieList
    self.listType = listType
    self.cellSize = CGSize(width: 120, height: 180)
  }
}
