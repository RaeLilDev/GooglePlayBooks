//
//  BuyLinkObject.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/13/22.
//

import Foundation
import RealmSwift

class BuyLinkObject: Object {
    @Persisted(primaryKey: true)
    var id: String
    
    @Persisted
    var name: String
    
    @Persisted
    var url: String
}
