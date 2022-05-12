//
//  HorizantalListCellViewModel.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import UIKit

class HorizantalListCellViewModel: HorizantalListCellViewModelable {
  var type: TableCellType
  var movieViewModelList: [SingleMovieCellViewModelable]
  var listType: HorizantalListType
  var cellHeight: CGFloat
  var itemSize: CGSize
  
  init(movieList: [Movie], listType: HorizantalListType) {
    self.movieViewModelList = movieList.compactMap({ SingleMovieCellViewModel(movie: $0) })
    self.listType = listType
    self.itemSize = CGSize(width: 120, height: 180)
    self.cellHeight = UITableView.automaticDimension
    self.type = .horizantal
  }
  
  func numberOfColoumn() -> Int {
    return self.movieViewModelList.count
  }
  
  func getCellViewModel(indexPath: IndexPath) -> SingleMovieCellViewModelable {
    return self.movieViewModelList[indexPath.item]
  }
}
