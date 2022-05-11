//
//  MovieListViewModel.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import UIKit
import Alamofire

class MovieListViewModel: MovieListViewModelable {
  
  var pageInfo: PageInfo = PageInfo()
  private var movieViewModelList: [SingleMovieCellViewModelable]
  private var client: WebServiceProtocol = WebService()
  
  var reloadAll: (() -> ())?
  var scrollToTop: (() -> ())?
  var updateSectionLayout: ((HighligtsMoviesType) -> ())?
  var stillLoading: Bool = false
  var listType: HighligtsMoviesType
  
  let cellInteritemSpacing: CGFloat! = 10
  private let coloumnCount: Int = 3
  
  init(initial movieList: [SingleMovieCellViewModelable], listType: HighligtsMoviesType) {
    movieViewModelList = movieList
    pageInfo.increasePageNumber()
    stillLoading = false
    self.listType = listType
    addPlaceHolderCellViewModel()
  }
  
  private func addPlaceHolderCellViewModel() {
    removePlaceHolderCellViewModelIfNeeded()
    let placeholderCellViewModel = SingleMovieCellViewModel(movie: nil, isPlaceholder: true)
    for _ in 0...2 { self.movieViewModelList.append(placeholderCellViewModel) }
  }
  
  func removePlaceHolderCellViewModelIfNeeded() {
    self.movieViewModelList.removeAll(where: { $0.isPlaceHolder })
  }
  
  func fetchMovieList() {
    stillLoading = true
    switch self.listType {
    case .topRated:
      client.getTopRatedMovies(pageIndex: self.pageInfo.nextPage, completion: apiMethodsCompletion())
    case .popular:
      client.getPopularMovies(pageIndex: self.pageInfo.nextPage, completion: apiMethodsCompletion())
    case .upcoming:
      client.getUpcomingMovies(pageIndex: self.pageInfo.nextPage, completion: apiMethodsCompletion())
    }
  }
  
  func apiMethodsCompletion() -> ((Result<MovieResponseModel, AFError>) -> Void) {
    return { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(let result):
        let movieList = result.results
        self.movieViewModelList.append(contentsOf: movieList.compactMap({ SingleMovieCellViewModel(movie: $0) as? SingleMovieCellViewModelable }))
        self.addPlaceHolderCellViewModel()
        self.pageInfo = PageInfo(with: result)
        self.reloadAll?()
        self.stillLoading = false
        if self.pageInfo.currentPage == 1 { self.scrollToTop?() }
      case .failure(let error):
        print("Error: ", error.errorDescription ?? "")
      }
    }
  }
  
  func numberOfItem() -> Int {
    return self.movieViewModelList.count
  }
  
  func getCellViewModel(indexPath: IndexPath) -> SingleMovieCellViewModelable {
    return self.movieViewModelList[indexPath.item]
  }
  
  func collectionCellSize() -> CGSize {
    let screenWidth = UIScreen.main.bounds.width
    let spaceCount = coloumnCount + 1
    let totalSpace: CGFloat = CGFloat(spaceCount) * cellInteritemSpacing
    let cellWidth = (screenWidth - totalSpace) / CGFloat(coloumnCount)
    let cellHeight = cellWidth * 1.5
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  func changeListType(movieType: HighligtsMoviesType) {
    guard movieType != listType else { return }
    pageInfo = PageInfo()
    self.listType = movieType
    self.movieViewModelList.removeAll()
    self.fetchMovieList()
    self.updateSectionLayout?(movieType)
  }
}
