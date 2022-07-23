//
//  BookSearchResponse.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/18/22.
//

import Foundation


// MARK: - UserVO
class BookSearchResponse: Codable {
    let kind: String?
    let totalItems: Int?
    let items: [Item]?

    init(kind: String?, totalItems: Int?, items: [Item]?) {
        self.kind = kind
        self.totalItems = totalItems
        self.items = items
    }
}

// MARK: - Item
class Item: Codable {
    let kind: String?
    let id, etag: String?
    let selfLink: String?
    let volumeInfo: VolumeInfo?
    let saleInfo: SaleInfo?
    let accessInfo: AccessInfo?
    let searchInfo: SearchInfo?

    init(kind: String?, id: String?, etag: String?, selfLink: String?, volumeInfo: VolumeInfo?, saleInfo: SaleInfo?, accessInfo: AccessInfo?, searchInfo: SearchInfo?) {
        self.kind = kind
        self.id = id
        self.etag = etag
        self.selfLink = selfLink
        self.volumeInfo = volumeInfo
        self.saleInfo = saleInfo
        self.accessInfo = accessInfo
        self.searchInfo = searchInfo
    }
    
    
    func toBookObject() -> BookObject {
        let object = BookObject()
        object.author = self.volumeInfo?.authors?.first ?? ""
        object.bookImage = (self.volumeInfo?.imageLinks?.thumbnail ?? "").replacingOccurrences(of: "http://", with: "https://")
        object.bookReviewLink = self.volumeInfo?.infoLink ?? ""
        object.createdDate = self.volumeInfo?.publishedDate ?? ""
        object.bookDescription = self.volumeInfo?.volumeInfoDescription ?? ""
        
        self.volumeInfo?.industryIdentifiers?.forEach { indextryIdentifier in
            if indextryIdentifier.type == "ISBN_13" {
                object.primaryIsbn13 = indextryIdentifier.identifier ?? ""
            }
        }
        
        
        object.publisher = self.volumeInfo?.publisher ?? ""
        object.rank = self.volumeInfo?.averageRating ?? 0
        object.title = self.volumeInfo?.title ?? ""
        return object
    }
}

// MARK: - AccessInfo
class AccessInfo: Codable {
    let country: String?
    let viewability: String?
    let embeddable, publicDomain: Bool?
    let textToSpeechPermission: String?
    let epub, pdf: Epub?
    let webReaderLink: String?
    let accessViewStatus: String?
    let quoteSharingAllowed: Bool?

    init(country: String?, viewability: String?, embeddable: Bool?, publicDomain: Bool?, textToSpeechPermission: String?, epub: Epub?, pdf: Epub?, webReaderLink: String?, accessViewStatus: String?, quoteSharingAllowed: Bool?) {
        self.country = country
        self.viewability = viewability
        self.embeddable = embeddable
        self.publicDomain = publicDomain
        self.textToSpeechPermission = textToSpeechPermission
        self.epub = epub
        self.pdf = pdf
        self.webReaderLink = webReaderLink
        self.accessViewStatus = accessViewStatus
        self.quoteSharingAllowed = quoteSharingAllowed
    }
}


// MARK: - Epub
class Epub: Codable {
    let isAvailable: Bool?
    let acsTokenLink: String?

    init(isAvailable: Bool?, acsTokenLink: String?) {
        self.isAvailable = isAvailable
        self.acsTokenLink = acsTokenLink
    }
}



// MARK: - SaleInfo
class SaleInfo: Codable {
    let country: String?
    let saleability: String?
    let isEbook: Bool?

    init(country: String?, saleability: String?, isEbook: Bool?) {
        self.country = country
        self.saleability = saleability
        self.isEbook = isEbook
    }
}


// MARK: - SearchInfo
class SearchInfo: Codable {
    let textSnippet: String?

    init(textSnippet: String?) {
        self.textSnippet = textSnippet
    }
}

// MARK: - VolumeInfo
class VolumeInfo: Codable {
    let title, subtitle: String?
    let authors: [String]?
    let publisher, publishedDate, volumeInfoDescription: String?
    let industryIdentifiers: [IndustryIdentifier]?
    let readingModes: ReadingModes?
    let pageCount: Int?
    let printType: String?
    let categories: [String]?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let panelizationSummary: PanelizationSummary?
    let imageLinks: ImageLinks?
    let language: String?
    let previewLink, infoLink: String?
    let canonicalVolumeLink: String?
    let averageRating, ratingsCount: Int?

    enum CodingKeys: String, CodingKey {
        case title, subtitle, authors, publisher, publishedDate
        case volumeInfoDescription = "description"
        case industryIdentifiers, readingModes, pageCount, printType, categories, maturityRating, allowAnonLogging, contentVersion, panelizationSummary, imageLinks, language, previewLink, infoLink, canonicalVolumeLink, averageRating, ratingsCount
    }

    init(title: String?, subtitle: String?, authors: [String]?, publisher: String?, publishedDate: String?, volumeInfoDescription: String?, industryIdentifiers: [IndustryIdentifier]?, readingModes: ReadingModes?, pageCount: Int?, printType: String?, categories: [String]?, maturityRating: String?, allowAnonLogging: Bool?, contentVersion: String?, panelizationSummary: PanelizationSummary?, imageLinks: ImageLinks?, language: String?, previewLink: String?, infoLink: String?, canonicalVolumeLink: String?, averageRating: Int?, ratingsCount: Int?) {
        self.title = title
        self.subtitle = subtitle
        self.authors = authors
        self.publisher = publisher
        self.publishedDate = publishedDate
        self.volumeInfoDescription = volumeInfoDescription
        self.industryIdentifiers = industryIdentifiers
        self.readingModes = readingModes
        self.pageCount = pageCount
        self.printType = printType
        self.categories = categories
        self.maturityRating = maturityRating
        self.allowAnonLogging = allowAnonLogging
        self.contentVersion = contentVersion
        self.panelizationSummary = panelizationSummary
        self.imageLinks = imageLinks
        self.language = language
        self.previewLink = previewLink
        self.infoLink = infoLink
        self.canonicalVolumeLink = canonicalVolumeLink
        self.averageRating = averageRating
        self.ratingsCount = ratingsCount
    }
}


// MARK: - ImageLinks
class ImageLinks: Codable {
    let smallThumbnail, thumbnail: String?

    init(smallThumbnail: String?, thumbnail: String?) {
        self.smallThumbnail = smallThumbnail
        self.thumbnail = thumbnail
    }
}

// MARK: - IndustryIdentifier
class IndustryIdentifier: Codable {
    let type: String?
    let identifier: String?

    init(type: String?, identifier: String?) {
        self.type = type
        self.identifier = identifier
    }
}


// MARK: - PanelizationSummary
class PanelizationSummary: Codable {
    let containsEpubBubbles, containsImageBubbles: Bool?

    init(containsEpubBubbles: Bool?, containsImageBubbles: Bool?) {
        self.containsEpubBubbles = containsEpubBubbles
        self.containsImageBubbles = containsImageBubbles
    }
}

// MARK: - ReadingModes
class ReadingModes: Codable {
    let text, image: Bool?

    init(text: Bool?, image: Bool?) {
        self.text = text
        self.image = image
    }
}
