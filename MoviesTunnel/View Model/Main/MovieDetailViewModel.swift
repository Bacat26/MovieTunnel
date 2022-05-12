//
//  MovieDetailViewModel.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import Foundation

enum MovieDetailTableCellType {
  case similarMovieList
  case overview
}

class MovieDetailViewModel {
  var movieName: String
  var genres: String?
  var review: String
  var duration: String?
  var releaseDate: String
  var isFavorite: Bool?
  var overview: String
  var hasVideo: Bool
  var movieId: Int
  var backdropUrl: URL?
  var posterUrl: URL?
  var updateByDetailResponse: (() -> ())?
  var detailCellViewModels: [BaseTableViewCellViewModelable]! = []
  
  private var client: WebServiceProtocol = WebService()
  
  init(movie: Movie) {
    self.movieName = movie.title ?? "Unknown Name"
    self.review = "\(movie.voteAverage ?? 0.0) (\(movie.voteCount ?? 0) Reviews)"
    self.releaseDate = movie.releaseDate ?? "Unknown Release Date"
    self.overview = movie.overview ?? "There is not any overview"
    self.hasVideo = movie.video ?? false
    self.movieId = movie.id
    self.backdropUrl = movie.backdropURL
    self.posterUrl = movie.posterURL
    addOverviewCellViewModel()
  }
  
  func addOverviewCellViewModel() {
    let overviewCellViewModel = MovieDescriptionViewModel(description: self.overview)
    self.detailCellViewModels.append(overviewCellViewModel)
  }
  
  func getMovieDetail() {
    client.getMovieDetail(with: movieId) { response in
      switch response {
      case .success(let result):
        self.parseMovieDetail(response: result)
      case .failure(let error):
        print("Error: ", error.errorDescription ?? "Unknown description")
      }
      self.getSimilarMovies()
    }
  }
  
  func getSimilarMovies() {
    client.getSimilarMovies(with: self.movieId) { response in
      switch response {
      case .success(let result):
        self.parseMoviesList(movieList: result.results, listType: .similar)
      case .failure(let error):
        print("Error: ", error.errorDescription ?? "Unknown description")
      }
      self.getRecommendationsMovies()
    }
  }
  
  func getRecommendationsMovies() {
    client.getRecommendationsMovies(with: self.movieId) { response in
      switch response {
      case .success(let result):
        self.parseMoviesList(movieList: result.results, listType: .recommendations)
      case .failure(let error):
        print("Error: ", error.errorDescription ?? "Unknown description")
      }
      self.updateByDetailResponse?()
    }
  }
  
  func parseMoviesList(movieList: [Movie], listType: HorizantalListType) {
    guard !movieList.isEmpty else { return }
    let cellViewModel = HorizantalListCellViewModel(movieList: movieList, listType: listType)
    self.detailCellViewModels.append(cellViewModel)
  }
  
  func parseMovieDetail(response: MovieDetailResponse) {
    parseGenres(genres: response.genres ?? [])
    self.updateByDetailResponse?()
  }
  
  private func parseGenres(genres: [Genre]) {
    let genresNameArray = genres.map( { $0.name })
    self.genres = genresNameArray.joined(separator: ", ")
  }
}
