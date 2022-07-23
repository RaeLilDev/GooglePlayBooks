//
//  BookListItem.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/21/22.
//

import Foundation


struct CommentListItem {
    let name: String
    let comments: [Comment]
    
    struct Comment {
        let rating: String
        let title: String
        let id: Int
    }
}
