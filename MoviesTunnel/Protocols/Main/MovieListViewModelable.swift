//
//  MovieListViewModelable.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import UIKit

protocol MovieListViewModelable {
  var reloadAll: (() -> ())? { get set }
  var scrollToTop: (() -> ())? { get set }
  var updateSectionLayout: ((HorizantalListType) -> ())? { get set }
  var stillLoading: Bool { get }
  var listType: HorizantalListType { get }
  var pageInfo: PageInfo { get }
  
  func fetchMovieList()
  func numberOfItem() -> Int
  func getCellViewModel(indexPath: IndexPath) -> SingleMovieCellViewModelable
  func collectionCellSize() -> CGSize
  func changeListType(movieType: HorizantalListType)
}

