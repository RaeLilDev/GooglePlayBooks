//
//  Enums.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/4/22.
//

import Foundation

enum ViewAsLayout: Int {
    case list
    case largeGrid
    case smallGrid
}


enum SortingOrder: Int {
    case recentlyOpened
    case title
    case author
}


enum HomeViewControllerSectionType {
    case RecentlyOpenedItems(items: [BookObject])
    case CategorySelection
    case ItemList(items: [ListObject])
}


enum BookDetailControllerSectionType {
    case BookInfoSection
    case BookActionSection
    case AboutBookSection
    case RatingAndReviewsSection
    case CommentList(comments: [CommentListItem])
}
