//
//  ArticleDTO.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import Foundation

struct MostPopularResponseDTO: Decodable {
    let results: [ArticleDTO]
}

struct ArticleDTO: Decodable {
    let id: Int
    let title: String
    let byline: String
    let publishedDate: String
    let abstract: String
    let url: String
    let media: [MediaDTO]?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case byline
        case publishedDate = "published_date"
        case abstract
        case url
        case media
    }
}

struct MediaDTO: Decodable {
    let mediaMetadata: [MediaMetadataDTO]?

    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadataDTO: Decodable {
    let url: String
}
