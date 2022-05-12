//
//  BaseTableViewCell.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import UIKit

enum TableCellType {
  case horizantal
  case movieOverview
}

protocol BaseTableViewCellViewModelable {
  var cellHeight: CGFloat { get }
  var type: TableCellType { get }
}
