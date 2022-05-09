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
    default:
      return params
    }
  }
  
  var methodType: HTTPMethod {
    switch self {
    case .popular, .latest, .upcoming, .topRated, .movieDetail:
      return .get
    }
  }
  
  var encoding: ParameterEncoding {
    switch self {
    case .popular, .latest, .upcoming, .topRated, .movieDetail:
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

