//
//  ArticleRepositoryImpl.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import Foundation

final class ArticleRepositoryImpl: ArticleRepository {
    private let remoteDataSource: NYTArticleRemoteDataSourceProtocol
    private let localDataSource: ArticleLocalDataSourceProtocol

    init(
        remoteDataSource: NYTArticleRemoteDataSourceProtocol,
        localDataSource: ArticleLocalDataSourceProtocol
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func fetchMostPopularArticles() async throws -> ArticleResult {
        do {
            let remoteArticles = try await remoteDataSource.fetchArticles()
            try await localDataSource.save(articles: remoteArticles)
            return ArticleResult(articles: remoteArticles, source: .remote)
            
        } catch {
            let localArticles = try await localDataSource.fetchArticles()
            
            if !localArticles.isEmpty {
                return ArticleResult(articles: localArticles, source: .local)
            }
            
            throw AppError.noInternetAndNoLocalData
        }
    }
}
