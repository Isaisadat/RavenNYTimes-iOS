//
//  ArticleDTOMapper.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import Foundation

enum ArticleDTOMapper {
    static func map(_ dto: ArticleDTO) -> Article {
        let imageURL = dto.media?
            .first?
            .mediaMetadata?
            .last?
            .url

        return Article(
            id: String(dto.id),
            title: dto.title,
            byline: dto.byline,
            publishedDate: dto.publishedDate,
            abstractText: dto.abstract,
            imageURL: imageURL,
            url: dto.url
        )
    }
}
