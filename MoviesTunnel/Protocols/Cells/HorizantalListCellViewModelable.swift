//
//  HorizantalListCellViewModelable.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import Foundation

protocol HorizantalListCellViewModelable: BaseTableViewCellViewModelable {
  var movieList: [Movie] { get }
  var listType: HighligtsMoviesType { get }
}
