//
//  WebService.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import Alamofire

protocol WebServiceProtocol {
  func getPopularMovies(pageIndex: Int, completion: @escaping (Result<MovieResponseModel, AFError>) -> Void)
  func getLatestMovies(pageIndex: Int, completion: @escaping (Result<MovieResponseModel, AFError>) -> Void)
  func getUpcomingMovies(pageIndex: Int, completion: @escaping (Result<MovieResponseModel, AFError>) -> Void)
  func getTopRatedMovies(pageIndex: Int, completion: @escaping (Result<MovieResponseModel, AFError>) -> Void)
  func getMovieDetail(with movieID: Int, completion: @escaping (Result<MovieDetailResponse, AFError>) -> Void)
}

class WebService: WebServiceProtocol {
  func getPopularMovies(pageIndex: Int, completion: @escaping (Result<MovieResponseModel, AFError>) -> Void) {
    request(method: .popular(pageIndex: pageIndex), completion: completion)
  }
  func getLatestMovies(pageIndex: Int, completion: @escaping (Result<MovieResponseModel, AFError>) -> Void) {
    request(method: .latest(pageIndex: pageIndex), completion: completion)
  }
  func getUpcomingMovies(pageIndex: Int, completion: @escaping (Result<MovieResponseModel, AFError>) -> Void) {
    request(method: .upcoming(pageIndex: pageIndex), completion: completion)
  }
  func getTopRatedMovies(pageIndex: Int, completion: @escaping (Result<MovieResponseModel, AFError>) -> Void) {
    request(method: .topRated(pageIndex: pageIndex), completion: completion)
  }
  func getMovieDetail(with movieID: Int, completion: @escaping (Result<MovieDetailResponse, AFError>) -> Void) {
    request(method: .movieDetail(movieID: movieID), completion: completion)
  }
  func getMoviesList(for type: APIMethods, pageIndex: Int, completion: @escaping (Result<MovieResponseModel, AFError>) -> Void) {
    request(method: .topRated(pageIndex: pageIndex), completion: completion)
  }
  
}

//MARK: General Usage
extension WebService {
  private func request<T:Decodable>(method: APIMethods, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) {
    AF.request(method)
      .responseDecodable(decoder: decoder) { (response: DataResponse<T, AFError>) in
        completion(response.result)
      }
  }
}

