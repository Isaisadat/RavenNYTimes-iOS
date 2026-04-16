//
//  ArticleListViewModelTests.swift
//  RavenNYTimesTests
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import XCTest
@testable import RavenNYTimes

@MainActor
final class ArticleListViewModelTests: XCTestCase {
    
    func test_loadArticles_shouldUpdateArticlesOnSuccess() async {
        let articles = [
            Article(
                id: "1",
                title: "Test",
                byline: "By Test",
                publishedDate: "2026-04-16",
                abstractText: "Summary",
                imageURL: nil,
                url: "https://example.com"
            )
        ]
        
        let result = ArticleResult(
            articles: articles,
            source: .remote
        )
        
        let useCase = MockGetMostPopularArticlesUseCase(result: .success(result))
        let viewModel = ArticleListViewModel(useCase: useCase)
        
        viewModel.loadArticles()
        
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        XCTAssertEqual(viewModel.articles, articles)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isOffline)
    }
    
    func test_loadArticles_shouldSetErrorOnFailure() async {
        let useCase = MockGetMostPopularArticlesUseCase(
            result: .failure(AppError.noInternetAndNoLocalData)
        )
        
        let viewModel = ArticleListViewModel(useCase: useCase)
        
        viewModel.loadArticles()
        
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        XCTAssertTrue(viewModel.articles.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, AppError.noInternetAndNoLocalData.localizedDescription)
    }
}
