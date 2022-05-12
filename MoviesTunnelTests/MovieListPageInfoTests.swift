//
//  MovieListPageInfoTests.swift
//  MoviesTunnelTests
//
//  Created by bilal acat on 12.05.2022.
//

import XCTest
@testable import MoviesTunnel

class MovieListPageInfoTests: XCTestCase {
  func testInitPagewithDummyMovieResponse() {
    let movieListResponse = MovieResponseModel(page: 3, results: DummyData().getMovieListDummy(number: 60), totalPages: 3, totalResults: 60)
    let pageInfo = PageInfo(with: movieListResponse)
    XCTAssertNotNil(pageInfo)
    XCTAssertEqual(pageInfo.currentPage, 3)
    XCTAssertEqual(pageInfo.nextPage, -1)
  }
  
  func testIncreasePageAsLastPage() {
    let movieListResponse = MovieResponseModel(page: 2, results: DummyData().getMovieListDummy(number: 60), totalPages: 3, totalResults: 60)
    var pageInfo = PageInfo(with: movieListResponse)
    XCTAssertNotNil(pageInfo)
    XCTAssertEqual(pageInfo.currentPage, 2)
    XCTAssertEqual(pageInfo.nextPage, 3)
    pageInfo.increasePageNumber()
    XCTAssertEqual(pageInfo.currentPage, 3)
    XCTAssertEqual(pageInfo.nextPage, -1)
  }
}

class DummyData {
  func getDummyMovie() -> Movie {
    return Movie(adult: false, backdropPath: "", genreIDS: [1,2,3], id: 639933, originalLanguage: "en-US", originalTitle: "The Northman", overview: "Overview of The Northman", popularity: 2.5, releaseDate: "21 Mar, 2019", title: "The Northman", video: false, voteAverage: 4.8, voteCount: 427, posterPath: nil)
  }
  
  func getMovieListDummy(number: Int) -> [Movie]{
    var movieList: [Movie] = []
    for i in 0...number - 1  {
      movieList.append(getDummyMovie())
    }
    return movieList
  }
}
