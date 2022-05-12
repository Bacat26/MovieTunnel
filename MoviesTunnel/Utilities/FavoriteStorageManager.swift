//
//  FavoriteStorageManager.swift
//  MoviesTunnel
//
//  Created by bilal acat on 12.05.2022.
//

import Foundation
import Default

class FavoriteStorageManager {
  static let shared = FavoriteStorageManager()
  private init(){}
  
  func getFavoriteList() -> [Movie]? {
    return UserDefaults.standard.df.fetch(forKey: "FavoriteList", type: [Movie].self) ?? []
  }
  
  func addItemFavoriteList(movie: Movie) {
    guard !isFavoriteMovie(movieId: movie.id) else { return }
    var movieList = self.getFavoriteList() ?? []
    movieList.append(movie)
    UserDefaults.standard.df.store(movieList, forKey: "FavoriteList")
  }
  
  func isFavoriteMovie(movieId: Int) -> Bool {
    let movieList = self.getFavoriteList() ?? []
    return movieList.contains(where: { $0.id == movieId })
  }
  
  func removeFavoriteMovie(movieID: Int) {
    var movieList = self.getFavoriteList() ?? []
    movieList.removeAll(where: { $0.id == movieID })
    UserDefaults.standard.df.store(movieList, forKey: "FavoriteList")
  }
}
