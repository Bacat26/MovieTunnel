//
//  MoviesApıClientTests.swift
//  MoviesTunnelTests
//
//  Created by bilal acat on 12.05.2022.
//

import XCTest
@testable import MoviesTunnel

class MoviesApıClientTests: XCTestCase {
  func testFetchPopularMovies() {
    let client = WebService()
    XCTAssertNotNil(client)
    
    let expectationReceive = XCTestExpectation(description: "receiveValue")
    let expectationFailure = XCTestExpectation(description: "failure")
    expectationFailure.isInverted = true
    
    client.getPopularMovies(pageIndex: 1) { response in
      switch response {
      case .success(let response):
        expectationReceive.fulfill()
        XCTAssertNotNil(response)
        XCTAssertGreaterThan(response.results.count, 0)
      case .failure(_):
        expectationFailure.fulfill()
      }
    }
    wait(for: [expectationReceive, expectationFailure], timeout: 5)
  }
  
  func testFetchTopRatedMovies() {
    let client = WebService()
    XCTAssertNotNil(client)
    
    let expectationReceive = XCTestExpectation(description: "receiveValue")
    let expectationFailure = XCTestExpectation(description: "failure")
    expectationFailure.isInverted = true
    
    client.getTopRatedMovies(pageIndex: 1) { response in
      switch response {
      case .success(let response):
        expectationReceive.fulfill()
        XCTAssertNotNil(response)
        XCTAssertGreaterThan(response.results.count, 0)
      case .failure(_):
        expectationFailure.fulfill()
      }
    }
    wait(for: [expectationReceive, expectationFailure], timeout: 5)
  }
  
  func testGetMovie() {
    var movie: MovieDetailResponse?
    
    let client = WebService()
    XCTAssertNotNil(client)
    
    let expectationReceive = XCTestExpectation(description: "receiveValue")
    let expectationFailure = XCTestExpectation(description: "failure")
    let expectationGenreFailure = XCTestExpectation(description: "can not find any Genre")
    expectationFailure.isInverted = true
    
    client.getMovieDetail(with: 639933) { response in
      switch response {
      case .success(let response):
        movie = response
        expectationReceive.fulfill()
        XCTAssertNotNil(response)
      case .failure(_):
        expectationFailure.fulfill()
      }
    }
    wait(for: [expectationReceive, expectationFailure], timeout: 2)
    XCTAssertNotNil(movie)
    XCTAssertEqual(movie?.title ?? "", "The Northman")
  }
  
  func testFetchRecommendationsMovies() {
    let client = WebService()
    XCTAssertNotNil(client)
    
    let expectationReceive = XCTestExpectation(description: "receiveValue")
    let expectationFailure = XCTestExpectation(description: "failure")
    expectationFailure.isInverted = true
    
    client.getRecommendationsMovies(with: 639933) { response in
      switch response {
      case .success(let response):
        expectationReceive.fulfill()
        XCTAssertNotNil(response)
        XCTAssertGreaterThan(response.results.count, 0)
        XCTAssertEqual(response.results.first?.id ?? 0, 338953)
      case .failure(_):
        expectationFailure.fulfill()
      }
    }
    wait(for: [expectationReceive, expectationFailure], timeout: 5)
  }
  
  func testFetchSimilarMovies() {
    let client = WebService()
    XCTAssertNotNil(client)
    
    let expectationReceive = XCTestExpectation(description: "receiveValue")
    let expectationFailure = XCTestExpectation(description: "failure")
    expectationFailure.isInverted = true
    
    client.getSimilarMovies(with: 639933) { response in
      switch response {
      case .success(let response):
        expectationReceive.fulfill()
        XCTAssertNotNil(response)
        XCTAssertGreaterThan(response.results.count, 0)
        XCTAssertEqual(response.results.first?.id ?? 0, 752)
      case .failure(_):
        expectationFailure.fulfill()
      }
    }
    wait(for: [expectationReceive, expectationFailure], timeout: 5)
  }
}
