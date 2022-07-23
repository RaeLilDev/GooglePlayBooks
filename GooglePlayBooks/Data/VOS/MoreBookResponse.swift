//
//  MoreBookResponse.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/9/22.
//

import Foundation

// MARK: - UserVO
class MoreBookResponse: Codable {
    let status, copyright: String?
    let numResults: Int?
    let lastModified: String?
    let results: ListResults?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case lastModified = "last_modified"
        case results
    }

    init(status: String?, copyright: String?, numResults: Int?, lastModified: String?, results: ListResults?) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.lastModified = lastModified
        self.results = results
    }
}

// MARK: - Results
class ListResults: Codable {
    
    let listName, listNameEncoded, bestsellersDate, publishedDate: String?
    let publishedDateDescription, nextPublishedDate, previousPublishedDate, displayName: String?
    let normalListEndsAt: Int?
    let updated: String?
    let books: [Book]?

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case publishedDateDescription = "published_date_description"
        case nextPublishedDate = "next_published_date"
        case previousPublishedDate = "previous_published_date"
        case displayName = "display_name"
        case normalListEndsAt = "normal_list_ends_at"
        case updated, books
    }

    init(listName: String?, listNameEncoded: String?, bestsellersDate: String?, publishedDate: String?, publishedDateDescription: String?, nextPublishedDate: String?, previousPublishedDate: String?, displayName: String?, normalListEndsAt: Int?, updated: String?, books: [Book]?) {
        self.listName = listName
        self.listNameEncoded = listNameEncoded
        self.bestsellersDate = bestsellersDate
        self.publishedDate = publishedDate
        self.publishedDateDescription = publishedDateDescription
        self.nextPublishedDate = nextPublishedDate
        self.previousPublishedDate = previousPublishedDate
        self.displayName = displayName
        self.normalListEndsAt = normalListEndsAt
        self.updated = updated
        self.books = books
    }
}


// MARK: - Isbn
class Isbn: Codable {
    let isbn10, isbn13: String?

    init(isbn10: String?, isbn13: String?) {
        self.isbn10 = isbn10
        self.isbn13 = isbn13
    }
}
