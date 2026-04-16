//
//  ArticleRepository.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import Foundation

protocol ArticleRepository {
    func fetchMostPopularArticles() async throws -> ArticleResult
}
