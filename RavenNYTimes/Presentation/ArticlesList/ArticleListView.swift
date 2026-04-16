//
//  ArticleListView.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject private var viewModel = ArticleListViewModel(
        useCase: AppContainer.shared.getArticlesUseCase
    )

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                content
            }
            .navigationTitle("Más populares")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if viewModel.articles.isEmpty {
                    viewModel.loadArticles()
                }
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.articles.isEmpty {
            loadingView
        } else if let errorMessage = viewModel.errorMessage, viewModel.articles.isEmpty {
            errorView(message: errorMessage)
        } else {
            articleListView
        }
    }

    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.15)

            Text("Cargando artículos...")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 42))
                .foregroundColor(.orange)

            Text("No fue posible cargar los artículos")
                .font(.headline)
                .multilineTextAlignment(.center)

            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)

            Button {
                viewModel.loadArticles()
            } label: {
                Text("Reintentar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(24)
    }

    private var articleListView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                headerView

                if viewModel.isOffline {
                    offlineBanner
                }

                LazyVStack(spacing: 20) {
                    ForEach(viewModel.articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            ArticleCardView(article: article)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 24)
        }
        .refreshable {
            viewModel.loadArticles()
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("The New York Times")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)

            Text("Articulos más populares")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Capsule()
                .fill(Color.blue.opacity(0.18))
                .frame(width: 72, height: 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var offlineBanner: some View {
        HStack(spacing: 10) {
            Image(systemName: "wifi.slash")
                .foregroundColor(.orange)

            Text("Mostrando datos sin conexión")
                .font(.subheadline)
                .foregroundColor(.orange)

            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color.orange.opacity(0.12))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.orange.opacity(0.18), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}
