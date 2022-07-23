//
//  BookObject.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/13/22.
//

import Foundation
import RealmSwift

class BookObject: Object {
    
    @Persisted
    var ageGroup: String
    
    @Persisted
    var amazonProductURL: String
    
    @Persisted
    var articleChapterLink: String
    
    @Persisted
    var author: String
    
    @Persisted
    var bookImage: String
    
    @Persisted
    var bookImageWidth: Int
    
    @Persisted
    var bookImageHeight: Int
    
    @Persisted
    var bookReviewLink: String
    
    @Persisted
    var contributor: String
    
    @Persisted
    var contributorNote: String
    
    @Persisted
    var createdDate: String
    
    @Persisted
    var bookDescription: String
    
    @Persisted
    var firstChapterLink: String
    
    @Persisted
    var price: String
    
    @Persisted
    var primaryIsbn10: String
    
    @Persisted(primaryKey: true)
    var primaryIsbn13: String
    
    @Persisted
    var bookURI: String
    
    @Persisted
    var publisher: String
    
    @Persisted
    var rank: Int
    
    @Persisted
    var rankLastWeek: Int
    
    @Persisted
    var sundayReviewLink: String
    
    @Persisted
    var title: String
    
    @Persisted
    var updatedDate: String
    
    @Persisted
    var weekOnList: Int
    
    @Persisted
    var buyLinks: List<BuyLinkObject>
    
    
    func toRecentViewObject() -> RecentViewObject {
        let object = RecentViewObject()
        object.id = self.primaryIsbn13
        object.date = Date()
        object.book = self
        return object
    }
    
    func toWishListObject() -> WishListObject {
        let object = WishListObject()
        object.id = self.primaryIsbn13
        object.date = Date()
        object.bookName = self.title
        object.authorName = self.author
        object.book = self
        return object
    }
}
