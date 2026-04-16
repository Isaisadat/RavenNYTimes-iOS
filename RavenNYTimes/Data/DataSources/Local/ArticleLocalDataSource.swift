//
//  ArticleLocalDataSource.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import Foundation
import CoreData

protocol ArticleLocalDataSourceProtocol {
    func save(articles: [Article]) async throws
    func fetchArticles() async throws -> [Article]
}

final class ArticleLocalDataSource: ArticleLocalDataSourceProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func save(articles: [Article]) async throws {
        try await context.perform {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ArticleEntity.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try self.context.execute(deleteRequest)

            for article in articles {
                let entity = ArticleEntity(context: self.context)
                entity.id = article.id
                entity.title = article.title
                entity.byline = article.byline
                entity.publishedDate = article.publishedDate
                entity.abstractText = article.abstractText
                entity.imageURL = article.imageURL
                entity.url = article.url
            }

            if self.context.hasChanges {
                try self.context.save()
            }
        }
    }

    func fetchArticles() async throws -> [Article] {
        try await context.perform {
            let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
            let results = try self.context.fetch(request)

            return results.map {
                Article(
                    id: $0.id ?? UUID().uuidString,
                    title: $0.title ?? "",
                    byline: $0.byline ?? "",
                    publishedDate: $0.publishedDate ?? "",
                    abstractText: $0.abstractText ?? "",
                    imageURL: $0.imageURL,
                    url: $0.url ?? ""
                )
            }
        }
    }
}
