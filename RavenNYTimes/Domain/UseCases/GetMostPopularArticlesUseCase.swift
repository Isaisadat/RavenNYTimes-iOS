//
//  GetMostPopularArticlesUseCase.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import Foundation

protocol GetMostPopularArticlesUseCase {
    func execute() async throws -> ArticleResult
}

final class GetMostPopularArticlesUseCaseImpl: GetMostPopularArticlesUseCase {
    private let repository: ArticleRepository

    init(repository: ArticleRepository) {
        self.repository = repository
    }

    func execute() async throws -> ArticleResult {
        try await repository.fetchMostPopularArticles()
    }
}
