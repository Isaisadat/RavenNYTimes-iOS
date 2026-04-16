//
//  ArticleCardView.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import SwiftUI

struct ArticleCardView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            imageSection

            VStack(alignment: .leading, spacing: 12) {
                Text(article.title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)

                Text(article.byline.isEmpty ? "Autor no disponible" : article.byline)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)

                HStack(spacing: 8) {
                    Image(systemName: "calendar")
                        .font(.caption)

                    Text(article.publishedDate)
                        .font(.caption)
                }
                .foregroundColor(.secondary)
            }
            .padding(18)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 6)
    }

    @ViewBuilder
    private var imageSection: some View {
        if let imageURL = article.imageURL,
           let url = URL(string: imageURL) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure:
                    imagePlaceholder

                case .empty:
                    loadingPlaceholder

                @unknown default:
                    imagePlaceholder
                }
            }
            .frame(height: 220)
            .frame(maxWidth: .infinity)
            .clipped()
        } else {
            imagePlaceholder
                .frame(height: 220)
        }
    }

    private var loadingPlaceholder: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.10))

            ProgressView()
        }
    }

    private var imagePlaceholder: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.10))

            Image(systemName: "photo")
                .font(.system(size: 28))
                .foregroundColor(.gray.opacity(0.6))
        }
    }
}
