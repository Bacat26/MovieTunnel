//
//  MovieDescriptionTableViewModel.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import UIKit

struct MovieDescriptionViewModel: MovieDescriptionViewModelable {
  var type: TableCellType
  var cellHeight: CGFloat
  var movieDescription: String
  
  init(description: String) {
    movieDescription = description
    cellHeight = UITableView.automaticDimension
    type = .movieOverview
  }
}
