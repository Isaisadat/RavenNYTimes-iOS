//
//  Article.swift
//  RavenNYTimes
//
//  Created by Isaí Abraham Innova on 16/04/26.
//

import Foundation

struct Article: Identifiable, Equatable {
    let id: String
    let title: String
    let byline: String
    let publishedDate: String
    let abstractText: String
    let imageURL: String?
    let url: String
}
