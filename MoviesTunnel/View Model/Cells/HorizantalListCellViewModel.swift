//
//  HorizantalListCellViewModel.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import UIKit

class HorizantalListCellViewModel: HorizantalListCellViewModelable {
  var movieViewModelList: [SingleMovieCellViewModelable]
  var listType: HighligtsMoviesType
  var cellSize: CGSize
  
  init(movieList: [Movie], listType: HighligtsMoviesType) {
    self.movieViewModelList = movieList.compactMap({ SingleMovieCellViewModel(movie: $0) as? SingleMovieCellViewModelable })
    self.listType = listType
    self.cellSize = CGSize(width: 120, height: 180)
  }
  
  func numberOfColoumn() -> Int {
    return self.movieViewModelList.count
  }
  
  func getCellViewModel(indexPath: IndexPath) -> SingleMovieCellViewModelable {
    return self.movieViewModelList[indexPath.item]
  }
}
