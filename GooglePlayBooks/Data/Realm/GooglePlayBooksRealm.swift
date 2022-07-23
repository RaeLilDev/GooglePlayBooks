//
//  GooglePlayBooksRealm.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/13/22.
//

import Foundation
import RealmSwift

class GooglePlayBooksRealm: NSObject {
    
    static let shared = GooglePlayBooksRealm()
    
    let db = try! Realm()
    
    override init() {
        
        super.init()
        
        print("Default Realm is at \(db.configuration.fileURL?.absoluteString ?? "undefined")")
    }
}
