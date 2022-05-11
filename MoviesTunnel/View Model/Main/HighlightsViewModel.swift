//
//  HighlightsViewModel.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import Foundation

enum HighligtsMoviesType: Int {
  case popular = 0
  case topRated = 1
  case upcoming = 2
  
  var title: String {
    switch self {
    case .popular:
      return "Popular"
    case .topRated:
      return "Top Rated"
    case .upcoming:
      return "Upcoming"
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
      self.reloadAll?()
    }
  }
}
