//
//  ArticleListViewModel.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import Foundation
import Combine

@MainActor
final class ArticleListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isOffline = false

    private let useCase: GetMostPopularArticlesUseCase

    init(useCase: GetMostPopularArticlesUseCase) {
        self.useCase = useCase
    }

    func loadArticles() {
        Task {
            isLoading = true
            errorMessage = nil
            isOffline = false

            do {
                let result = try await useCase.execute()
                articles = result.articles
                isOffline = (result.source == .local)
            } catch {
                errorMessage = error.localizedDescription
            }

            isLoading = false
        }
    }
}
