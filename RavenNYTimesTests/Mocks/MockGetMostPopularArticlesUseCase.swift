//
//  MockGetMostPopularArticlesUseCase.swift
//  RavenNYTimesTests
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import Foundation
@testable import RavenNYTimes

final class MockGetMostPopularArticlesUseCase: GetMostPopularArticlesUseCase {
    var result: Result<ArticleResult, Error>
    
    init(result: Result<ArticleResult, Error>) {
        self.result = result
    }
    
    func execute() async throws -> ArticleResult {
        switch result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
