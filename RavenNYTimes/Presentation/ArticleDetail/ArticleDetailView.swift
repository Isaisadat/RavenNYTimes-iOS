//
//  ArticleDetailView.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: Article

    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let headerHeight = min(max(screenHeight * 0.36, 260), 360)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    headerSection(height: headerHeight)

                    VStack(alignment: .leading, spacing: 24) {
                        topMetaSection
                        titleSection
                        infoBlocks
                        Divider()
                        summarySection
                        openArticleButton
                    }
                    .padding(24)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .stroke(Color.black.opacity(0.04), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.08), radius: 14, x: 0, y: 8)
                    .padding(.horizontal, 16)
                    .padding(.top, -42)
                }
                .padding(.bottom, 28)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Detalle")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(edges: .top)
        }
    }

    private func headerSection(height: CGFloat) -> some View {
        ZStack(alignment: .bottom) {
            headerImage(height: height)

            LinearGradient(
                colors: [
                    Color.clear,
                    Color(.systemGroupedBackground).opacity(0.15),
                    Color(.systemGroupedBackground).opacity(0.55),
                    Color(.systemGroupedBackground).opacity(0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: height * 0.42)
        }
    }

    @ViewBuilder
    private func headerImage(height: CGFloat) -> some View {
        if let imageURL = article.imageURL,
           let url = URL(string: imageURL) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure:
                    placeholderHeader

                case .empty:
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.10))
                        ProgressView()
                    }

                @unknown default:
                    placeholderHeader
                }
            }
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .clipped()
        } else {
            placeholderHeader
                .frame(height: height)
                .frame(maxWidth: .infinity)
        }
    }

    private var placeholderHeader: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.18),
                    Color.purple.opacity(0.10)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 10) {
                Image(systemName: "photo")
                    .font(.system(size: 44))
                    .foregroundColor(.blue.opacity(0.70))

                Text("The New York Times")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.blue.opacity(0.75))
            }
        }
    }

    private var topMetaSection: some View {
        HStack {
            Text("Más popular")
                .font(.caption.weight(.semibold))
                .foregroundColor(.blue)
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(Color.blue.opacity(0.10))
                .clipShape(Capsule())

            Spacer()
        }
    }

    private var titleSection: some View {
        Text(article.title)
            .font(.system(size: 30, weight: .bold))
            .foregroundColor(.primary)
            .lineSpacing(2)
            .fixedSize(horizontal: false, vertical: true)
    }

    private var infoBlocks: some View {
        VStack(alignment: .leading, spacing: 16) {
            infoRow(
                icon: "person.crop.circle.fill",
                iconColor: .blue,
                title: "Autor",
                value: article.byline.isEmpty ? "No disponible" : article.byline
            )

            infoRow(
                icon: "calendar",
                iconColor: .orange,
                title: "Fecha de publicación",
                value: article.publishedDate
            )
        }
    }

    private func infoRow(
        icon: String,
        iconColor: Color,
        title: String,
        value: String
    ) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .font(.title3)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
    }

    private var summarySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Resumen")
                .font(.title3.weight(.semibold))
                .foregroundColor(.primary)

            Text(article.abstractText)
                .font(.body)
                .foregroundColor(.primary)
                .lineSpacing(7)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    @ViewBuilder
    private var openArticleButton: some View {
        if let url = URL(string: article.url) {
            Link(destination: url) {
                HStack(spacing: 10) {
                    Image(systemName: "safari")
                    Text("Abrir artículo original")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(
                        colors: [
                            Color.blue,
                            Color.blue.opacity(0.82)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .clipShape(Capsule())
                .shadow(color: .blue.opacity(0.20), radius: 10, x: 0, y: 6)
            }
            .padding(.top, 4)
        }
    }
}
