//
//  News.swift
//  MNews
//
//  Created by admin on 28.05.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import Foundation

// MARK: - Empty
struct Empty: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
//  let articles: String
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}
