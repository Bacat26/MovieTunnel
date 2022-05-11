//
//  HorizantalListCellViewModelable.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import Foundation

protocol HorizantalListCellViewModelable: BaseTableViewCellViewModelable {
  var movieViewModelList: [SingleMovieCellViewModelable] { get }
  var listType: HighligtsMoviesType { get }
  
  func numberOfColoumn() -> Int
  func getCellViewModel(indexPath: IndexPath) -> SingleMovieCellViewModelable
}
