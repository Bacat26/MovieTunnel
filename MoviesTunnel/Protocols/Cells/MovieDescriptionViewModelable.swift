//
//  MovieDescriptionViewModelable.swift
//  MoviesTunnel
//
//  Created by bilal acat on 12.05.2022.
//

import UIKit

protocol MovieDescriptionViewModelable: BaseTableViewCellViewModelable {
  var type: TableCellType { get }
  var cellHeight: CGFloat { get }
  var movieDescription: String { get }
}
