//
//  BookListResponse.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/9/22.
//

import Foundation


class BookListResponse: Codable {
    let status, copyright: String?
    let numResults: Int?
    let results: Results?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }

    init(status: String?, copyright: String?, numResults: Int?, results: Results?) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
}


// MARK: - Results
class Results: Codable {
    let bestsellersDate, publishedDate, publishedDateDescription, previousPublishedDate: String?
    let nextPublishedDate: String?
    let lists: [ListVO]?

    enum CodingKeys: String, CodingKey {
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case publishedDateDescription = "published_date_description"
        case previousPublishedDate = "previous_published_date"
        case nextPublishedDate = "next_published_date"
        case lists
    }

    init(bestsellersDate: String?, publishedDate: String?, publishedDateDescription: String?, previousPublishedDate: String?, nextPublishedDate: String?, lists: [ListVO]?) {
        self.bestsellersDate = bestsellersDate
        self.publishedDate = publishedDate
        self.publishedDateDescription = publishedDateDescription
        self.previousPublishedDate = previousPublishedDate
        self.nextPublishedDate = nextPublishedDate
        self.lists = lists
    }
}

// MARK: - List
class ListVO: Codable {
    let listID: Int?
    let listName, listNameEncoded, displayName: String?
    let updated: String?
    let listImage: String?
    let listImageWidth, listImageHeight: Int?
    let books: [Book]?

    enum CodingKeys: String, CodingKey {
        case listID = "list_id"
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
        case displayName = "display_name"
        case updated
        case listImage = "list_image"
        case listImageWidth = "list_image_width"
        case listImageHeight = "list_image_height"
        case books
    }

    init(listID: Int?, listName: String?, listNameEncoded: String?, displayName: String?, updated: String?, listImage: String?, listImageWidth: Int?, listImageHeight: Int?, books: [Book]?) {
        self.listID = listID
        self.listName = listName
        self.listNameEncoded = listNameEncoded
        self.displayName = displayName
        self.updated = updated
        self.listImage = listImage
        self.listImageWidth = listImageWidth
        self.listImageHeight = listImageHeight
        self.books = books
    }
    
    func toListObject() -> ListObject {
        let object = ListObject()
        object.listID = self.listID ?? 0
        object.listName = self.listName ?? ""
        object.listNameEncoded = self.listNameEncoded ?? ""
        object.displayName = self.displayName ?? ""
        object.updated = self.updated ?? ""
        object.listImage = self.listImage ?? ""
        object.listImageWidth = self.listImageWidth ?? 0
        object.listImageHeight = self.listImageHeight ?? 0
        object.books.append(objectsIn: self.books?.map { $0.toBookObject() } ?? [BookObject]())
        return object
        
    }
}

// MARK: - Book
class Book: Codable {
    let ageGroup: String?
    let amazonProductURL: String?
    let articleChapterLink, author: String?
    let bookImage: String?
    let bookImageWidth, bookImageHeight: Int?
    let bookReviewLink: String?
    let contributor: String?
    let contributorNote: String?
    let createdDate, bookDescription, firstChapterLink, price: String?
    let primaryIsbn10, primaryIsbn13, bookURI, publisher: String?
    let rank, rankLastWeek: Int?
    let sundayReviewLink: String?
    let title, updatedDate: String?
    let weeksOnList: Int?
    let buyLinks: [BuyLink]?
    let isbns: [Isbn]?

    enum CodingKeys: String, CodingKey {
        case ageGroup = "age_group"
        case amazonProductURL = "amazon_product_url"
        case articleChapterLink = "article_chapter_link"
        case author
        case bookImage = "book_image"
        case bookImageWidth = "book_image_width"
        case bookImageHeight = "book_image_height"
        case bookReviewLink = "book_review_link"
        case contributor
        case contributorNote = "contributor_note"
        case createdDate = "created_date"
        case bookDescription = "description"
        case firstChapterLink = "first_chapter_link"
        case price
        case primaryIsbn10 = "primary_isbn10"
        case primaryIsbn13 = "primary_isbn13"
        case bookURI = "book_uri"
        case publisher, rank
        case rankLastWeek = "rank_last_week"
        case sundayReviewLink = "sunday_review_link"
        case title
        case updatedDate = "updated_date"
        case weeksOnList = "weeks_on_list"
        case buyLinks = "buy_links"
        case isbns
    }

    init(ageGroup: String?, amazonProductURL: String?, articleChapterLink: String?, author: String?, bookImage: String?, bookImageWidth: Int?, bookImageHeight: Int?, bookReviewLink: String?, contributor: String?, contributorNote: String?, createdDate: String?, bookDescription: String?, firstChapterLink: String?, price: String?, primaryIsbn10: String?, primaryIsbn13: String?, bookURI: String?, publisher: String?, rank: Int?, rankLastWeek: Int?, sundayReviewLink: String?, title: String?, updatedDate: String?, weeksOnList: Int?, buyLinks: [BuyLink]?, isbns: [Isbn]?) {
        self.ageGroup = ageGroup
        self.amazonProductURL = amazonProductURL
        self.articleChapterLink = articleChapterLink
        self.author = author
        self.bookImage = bookImage
        self.bookImageWidth = bookImageWidth
        self.bookImageHeight = bookImageHeight
        self.bookReviewLink = bookReviewLink
        self.contributor = contributor
        self.contributorNote = contributorNote
        self.createdDate = createdDate
        self.bookDescription = bookDescription
        self.firstChapterLink = firstChapterLink
        self.price = price
        self.primaryIsbn10 = primaryIsbn10
        self.primaryIsbn13 = primaryIsbn13
        self.bookURI = bookURI
        self.publisher = publisher
        self.rank = rank
        self.rankLastWeek = rankLastWeek
        self.sundayReviewLink = sundayReviewLink
        self.title = title
        self.updatedDate = updatedDate
        self.weeksOnList = weeksOnList
        self.buyLinks = buyLinks
        self.isbns = isbns
    }
    
    func toBookObject() -> BookObject {
        var count = 0
        let object = BookObject()
        object.ageGroup = self.ageGroup ?? ""
        object.amazonProductURL = self.amazonProductURL ?? ""
        object.articleChapterLink = self.articleChapterLink ?? ""
        object.author = self.author ?? ""
        object.bookImage = self.bookImage ?? ""
        object.bookImageWidth = self.bookImageWidth ?? 0
        object.bookImageHeight = self.bookImageHeight ?? 0
        object.bookReviewLink = self.bookReviewLink ?? ""
        object.contributor = self.contributor ?? ""
        object.contributorNote = self.contributorNote ?? ""
        object.createdDate = self.createdDate ?? ""
        object.bookDescription = self.bookDescription ?? ""
        object.firstChapterLink = self.firstChapterLink ?? ""
        object.price = self.price ?? ""
        object.primaryIsbn10 = self.primaryIsbn10 ?? ""
        object.primaryIsbn13 = self.primaryIsbn13 ?? ""
        object.bookURI = self.bookURI ?? ""
        object.publisher = self.publisher ?? ""
        object.rank = self.rank ?? 0
        object.rankLastWeek = self.rankLastWeek ?? 0
        object.sundayReviewLink = self.sundayReviewLink ?? ""
        object.title = self.title ?? ""
        object.updatedDate = self.updatedDate ?? ""
        object.weekOnList = self.weeksOnList ?? 0
        
        object.buyLinks.append(objectsIn: self.buyLinks?.map{
            count += 1
            let buyLinkId = "\(self.primaryIsbn13 ?? "")\(count)"
            return $0.toBuyLinkObject(with: buyLinkId)
            
        } ?? [BuyLinkObject]())
        return object
    }
}

// MARK: - BuyLink
class BuyLink: Codable {
    let name: String?
    let url: String?

    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
    
    func toBuyLinkObject(with id: String) -> BuyLinkObject {
        let object = BuyLinkObject()
        object.id = id
        object.name = self.name ?? ""
        object.url = self.url ?? ""
        return object
    }
}
