//
//  ShelfObject.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/21/22.
//

import Foundation
import RealmSwift

class ShelfObject: Object {
    
    @Persisted(primaryKey: true)
    var id: String
    
    @Persisted
    var shelfName: String
    
    @Persisted
    var shelfImage: String
    
    @Persisted
    var books: List<ShelfBookObject>
    
}
