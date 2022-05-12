//
//  MovieVideosResponse.swift
//  MoviesTunnel
//
//  Created by bilal acat on 12.05.2022.
//

import Foundation

struct MovieVideosResponse: Codable {
    let id: Int
    let results: [Video]
}

// MARK: - Result
struct Video: Codable {
    let iso639_1, iso3166_1, name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
