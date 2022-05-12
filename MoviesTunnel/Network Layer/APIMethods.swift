//
//  APIMethods.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import Alamofire

enum APIMethods: URLRequestConvertible {
  case popular(pageIndex: Int)
  case latest(pageIndex: Int)
  case upcoming(pageIndex: Int)
  case topRated(pageIndex: Int)
  case movieDetail(movieID: Int)
  case similarMovies(movieID: Int)
  case recommendationsMovies(movieID: Int)
  
  var path: String {
    switch self {
    case .popular:
      return "popular"
    case .latest:
      return "latest"
    case .upcoming:
      return "upcoming"
    case .topRated:
      return "top_rated"
    case let .movieDetail(movieID):
      return "\(movieID)"
    case let .similarMovies(movieID):
      return "\(movieID)/similar"
    case let .recommendationsMovies(movieID):
      return "\(movieID)/recommendations"
    }
  }
  
  var parameters: Parameters {
    var params: [String: Any] = [ParameterKey.apiKey.rawValue: Constant.WebService.apiKey,
                                 ParameterKey.language.rawValue: Constant.WebService.language
    ]
    
    switch self {
    case .popular(let pageIndex), .latest(let pageIndex), .upcoming(let pageIndex), .topRated(let pageIndex):
      params[ParameterKey.pageIndex.rawValue] = "\(pageIndex)"
      return params
    case .recommendationsMovies, .similarMovies:
      params[ParameterKey.pageIndex.rawValue] = "1"
      return params
    default:
      return params
    }
  }
  
  var methodType: HTTPMethod {
    switch self {
    case .popular, .latest, .upcoming, .topRated, .movieDetail, .similarMovies, .recommendationsMovies:
      return .get
    }
  }
  
  var encoding: ParameterEncoding {
    switch self {
    case .popular, .latest, .upcoming, .topRated, .movieDetail, .similarMovies, .recommendationsMovies:
      return URLEncoding.queryString
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try Constant.WebService.BASE_URL.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = methodType.rawValue
    urlRequest = try encoding.encode(urlRequest, with: parameters)
    return urlRequest
  }
  
  enum ParameterKey: String {
    case language = "language"
    case apiKey = "api_key"
    case pageIndex = "page"
  }
}

