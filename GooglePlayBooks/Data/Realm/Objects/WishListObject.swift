//
//  WishListObject.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/20/22.
//

import Foundation
import RealmSwift

class WishListObject: Object {
    
    @Persisted(primaryKey: true)
    var id: String
    
    @Persisted
    var date: Date = Date()
    
    @Persisted
    var bookName: String
    
    @Persisted
    var authorName: String
    
    @Persisted
    var book: BookObject?
    
}
