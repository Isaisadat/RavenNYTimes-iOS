//
//  GetMostPopularArticlesUseCaseTests.swift
//  RavenNYTimesTests
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import XCTest
@testable import RavenNYTimes

final class GetMostPopularArticlesUseCaseTests: XCTestCase {
    
    func test_execute_shouldReturnArticlesFromRepository() async throws {
        let expectedArticles = [
            Article(
                id: "1",
                title: "Title 1",
                byline: "By Author",
                publishedDate: "2026-04-16",
                abstractText: "Summary",
                imageURL: nil,
                url: "https://example.com"
            )
        ]
        
        let expectedResult = ArticleResult(
            articles: expectedArticles,
            source: .remote
        )
        
        let repository = MockArticleRepository(result: .success(expectedResult))
        let useCase = GetMostPopularArticlesUseCaseImpl(repository: repository)
        
        let result = try await useCase.execute()
        
        XCTAssertEqual(result.articles, expectedArticles)
        XCTAssertEqual(result.source, .remote)
    }
}
