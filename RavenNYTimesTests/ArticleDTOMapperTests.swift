//
//  ArticleDTOMapperTests.swift
//  RavenNYTimesTests
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import XCTest
@testable import RavenNYTimes

final class ArticleDTOMapperTests: XCTestCase {

    func test_map_shouldConvertDTOToDomainEntityCorrectly() {
        let dto = ArticleDTO(
            id: 123,
            title: "Test Title",
            byline: "By Test Author",
            publishedDate: "2026-04-16",
            abstract: "This is a summary",
            url: "https://example.com/article",
            media: [
                MediaDTO(
                    mediaMetadata: [
                        MediaMetadataDTO(url: "https://example.com/image_small.jpg"),
                        MediaMetadataDTO(url: "https://example.com/image_large.jpg")
                    ]
                )
            ]
        )

        let article = ArticleDTOMapper.map(dto)

        XCTAssertEqual(article.id, "123")
        XCTAssertEqual(article.title, "Test Title")
        XCTAssertEqual(article.byline, "By Test Author")
        XCTAssertEqual(article.publishedDate, "2026-04-16")
        XCTAssertEqual(article.abstractText, "This is a summary")
        XCTAssertEqual(article.url, "https://example.com/article")
        XCTAssertEqual(article.imageURL, "https://example.com/image_large.jpg")
    }
}
