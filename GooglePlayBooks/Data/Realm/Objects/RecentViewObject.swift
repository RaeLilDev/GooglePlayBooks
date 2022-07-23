//
//  RecentViewObject.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/17/22.
//

import Foundation
import RealmSwift

class RecentViewObject: Object {
    
    @Persisted(primaryKey: true)
    var id: String
    
    @Persisted
    var date: Date = Date()
    
    @Persisted
    var book: BookObject?
    
}
