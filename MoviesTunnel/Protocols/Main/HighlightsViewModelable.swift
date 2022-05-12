//
//  HighlightsViewModelable.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import Foundation

protocol HighlightsViewModelable {
  func getList()
  func getFavoriteList()
  func numberOfRowsTableView() -> Int
  func getCellViewModel(indexPath: IndexPath) -> HorizantalListCellViewModelable
  
  var reloadAll: (() -> ())? { get set }
  var highlightListCellViewModels: [HorizantalListCellViewModelable]! { get }
}
