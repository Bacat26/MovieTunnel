//
//  MovieDetailResponseModel.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import Foundation

struct MovieDetailResponse: Codable {
  let adult: Bool?
  let backdropPath: String?
  let budget: Int?
  let genres: [Genre]?
  let homepage: String?
  let id: Int
  let imdbID: String?
  let originalLanguage, originalTitle: String
  let overview: String?
  let popularity: Double?
  let posterPath: String?
  let productionCompanies: [ProductionCompany]?
  let productionCountries: [ProductionCountry]?
  let releaseDate: String
  let revenue: Int?
  let runtime: Int?
  let spokenLanguages: [SpokenLanguage]?
  let status, title: String
  let tagline: String?
  let video: Bool?
  let voteAverage: Double?
  let voteCount: Int?
  lazy var backdropURL: String? = {
      return ("https://image.tmdb.org/t/p/w500" + (backdropPath ?? ""))
  }()
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case budget, genres, homepage, id
    case imdbID = "imdb_id"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview, popularity
    case posterPath = "poster_path"
    case productionCompanies = "production_companies"
    case productionCountries = "production_countries"
    case releaseDate = "release_date"
    case revenue, runtime
    case spokenLanguages = "spoken_languages"
    case status, tagline, title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

// MARK: - Genre
struct Genre: Codable {
  let id: Int
  let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
  let id: Int
  let logoPath: String?
  let name, originCountry: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case logoPath = "logo_path"
    case name
    case originCountry = "origin_country"
  }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
  let iso3166_1, name: String
  
  enum CodingKeys: String, CodingKey {
    case iso3166_1 = "iso_3166_1"
    case name
  }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
  let englishName, iso639_1, name: String
  
  enum CodingKeys: String, CodingKey {
    case englishName = "english_name"
    case iso639_1 = "iso_639_1"
    case name
  }
}
