//
//  AppContainer.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import Foundation
import CoreData

final class AppContainer {
    static let shared = AppContainer()

    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = PersistenceController.shared.container
    }

    lazy var articleRepository: ArticleRepository = {
        let remote = NYTArticleRemoteDataSource()
        let local = ArticleLocalDataSource(context: persistentContainer.viewContext)

        return ArticleRepositoryImpl(
            remoteDataSource: remote,
            localDataSource: local
        )
    }()

    lazy var getArticlesUseCase: GetMostPopularArticlesUseCase = {
        GetMostPopularArticlesUseCaseImpl(repository: articleRepository)
    }()
}
