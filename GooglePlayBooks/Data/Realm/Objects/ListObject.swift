//
//  ListObject.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/13/22.
//

import Foundation
import RealmSwift

class ListObject: Object {
    
    @Persisted(primaryKey: true)
    var listID: Int
    
    @Persisted
    var listName: String
    
    @Persisted
    var listNameEncoded: String
    
    @Persisted
    var displayName: String
    
    @Persisted
    var updated: String
    
    @Persisted
    var listImage: String?
    
    @Persisted
    var listImageWidth: Int?
    
    @Persisted
    var listImageHeight: Int?
    
    @Persisted
    var books: List<BookObject>
}
