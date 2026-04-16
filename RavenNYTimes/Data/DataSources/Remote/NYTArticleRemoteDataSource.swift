//
//  NYTArticleRemoteDataSource.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import Foundation

protocol NYTArticleRemoteDataSourceProtocol {
    func fetchArticles() async throws -> [Article]
}

final class NYTArticleRemoteDataSource: NYTArticleRemoteDataSourceProtocol {
    private let apiKey = "qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ"

    func fetchArticles() async throws -> [Article] {
        guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=\(apiKey)") else {
            throw AppError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode else {
                throw AppError.invalidResponse
            }

            let decoded = try JSONDecoder().decode(MostPopularResponseDTO.self, from: data)
            return decoded.results.map { ArticleDTOMapper.map($0) }
        } catch let error as AppError {
            throw error
        } catch let decodingError as DecodingError {
            print("Decoding error: \(decodingError)")
            throw AppError.decodingError
        } catch {
            throw AppError.networkError(error.localizedDescription)
        }
    }
}
