//
//  PageInfo.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import Foundation

struct PageInfo {
  var totalPage: Int
  var currentPage: Int
  var nextPage: Int
  var hasNextPage: Bool
  
  init(with listResponseModel: MovieResponseModel) {
    self.totalPage = listResponseModel.totalPages
    self.currentPage = listResponseModel.page
    self.hasNextPage = currentPage < totalPage
    self.nextPage = hasNextPage ? currentPage + 1 : -1 
  }
  
  init() {
    self.currentPage = 0
    self.totalPage = 1000
    self.nextPage = currentPage + 1
    self.hasNextPage = currentPage < totalPage
  }
  
  mutating func increasePageNumber() {
    guard self.currentPage < totalPage else { return }
    currentPage += 1
    hasNextPage = currentPage < totalPage
    self.nextPage = hasNextPage ? currentPage + 1 : -1 
  }
}
