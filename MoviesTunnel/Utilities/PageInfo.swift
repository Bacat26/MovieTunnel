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
    self.nextPage = currentPage + 1
    self.hasNextPage = currentPage < totalPage
    
  }
  
  init() {
    self.currentPage = 0
    self.totalPage = 1000
    self.nextPage = currentPage + 1
    self.hasNextPage = currentPage < totalPage
  }
  
  mutating func increasePageNumber() {
    currentPage += 1
    nextPage = currentPage + 1
    hasNextPage = currentPage < totalPage
  }
}
