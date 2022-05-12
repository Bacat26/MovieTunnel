//
//  HighlightsViewModel.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import Foundation

enum HorizantalListType: Int {
  case popular = 0
  case topRated = 1
  case upcoming = 2
  case favorites = 3
  case similar = 4
  case recommendations = 5
  
  var title: String {
    switch self {
    case .popular:
      return "Popular"
    case .topRated:
      return "Top Rated"
    case .upcoming:
      return "Upcoming"
    case .similar:
      return "Similar Movies"
    case .recommendations:
      return "Recommendations"
    case .favorites:
      return "My Favorites"
    }
  }
  
  var showAllEnable: Bool {
    switch self {
    case .popular:
      return true
    case .topRated:
      return true
    case .upcoming:
      return true
    case .similar:
      return false
    case .recommendations:
      return false
    case .favorites:
      return false
    }
  }
}

class HighlightsViewModel: HighlightsViewModelable {
  
  private var client: WebServiceProtocol = WebService()
  internal var highlightListCellViewModels: [HorizantalListCellViewModelable]! = []
  var reloadAll: (() -> ())?
  
  init() {
    self.getList()
  }
  
  func getList() {
    getPopularMovieList()
  }
  
  func numberOfRowsTableView()  -> Int {
    return highlightListCellViewModels.count
  }
  
  func getCellViewModel(indexPath: IndexPath) -> HorizantalListCellViewModelable {
    return highlightListCellViewModels[indexPath.row]
  }
  
  func getPopularMovieList() {
    client.getPopularMovies(pageIndex: 1) { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(let result):
        let horizantalListCellViewModel = HorizantalListCellViewModel(movieList: result.results, listType: .popular)
        self.highlightListCellViewModels.append(horizantalListCellViewModel)
      case .failure(let error):
        print("Error: ", error.errorDescription ?? "")
      }
      self.getUpCommingMovieList()
    }
  }
  
  func getUpCommingMovieList() {
    client.getUpcomingMovies(pageIndex: 1) { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(let result):
        self.highlightListCellViewModels.append(HorizantalListCellViewModel(movieList: result.results, listType: .upcoming))
      case .failure(let error):
        print("Error: ", error.errorDescription ?? "")
      }
      self.getTopRatedMovieList()
    }
  }
  
  func getTopRatedMovieList() {
    client.getTopRatedMovies(pageIndex: 1) { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(let result):
        self.highlightListCellViewModels.append(HorizantalListCellViewModel(movieList: result.results, listType: .topRated))
      case .failure(let error):
        print("Error: ", error.errorDescription ?? "")
      }
      self.getFavoriteList()
    }
  }
  
  func getFavoriteList() {
    guard let favoriteMovieList = FavoriteStorageManager.shared.getFavoriteList(), !favoriteMovieList.isEmpty else {
      self.reloadAll?()
      return
    }
    self.highlightListCellViewModels.removeAll(where: {$0.listType == .favorites})
    self.highlightListCellViewModels.append(HorizantalListCellViewModel(movieList: favoriteMovieList, listType: .favorites))
    self.reloadAll?()
  }
}
