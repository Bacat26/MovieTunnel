//
//  HorizantalListCellViewModelable.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import UIKit

protocol HorizantalListCellViewModelable: BaseTableViewCellViewModelable {
  var movieViewModelList: [SingleMovieCellViewModelable] { get }
  var listType: HorizantalListType { get }
  var itemSize: CGSize { get }
  
  func numberOfColoumn() -> Int
  func getCellViewModel(indexPath: IndexPath) -> SingleMovieCellViewModelable
}
