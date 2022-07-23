//
//  ShelfBookObject.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/21/22.
//

import Foundation
import RealmSwift

class ShelfBookObject: Object {
    
    @Persisted(primaryKey: true)
    var id: String
    
    @Persisted
    var shelfId: String
    
    @Persisted
    var date: Date = Date()
    
    @Persisted
    var bookName: String
    
    @Persisted
    var authorName: String
    
    @Persisted
    var book: BookObject?
    
}
