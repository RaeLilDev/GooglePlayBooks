//
//  BookDetailViewModel.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/21/22.
//

import Foundation
import Combine

enum BookDetailViewState {

    case addToWishList
    
    case deleteFromLibrary
    
    case failure(message: String)
    
}


class BookDetailViewModel {
    
    var viewState: PassthroughSubject<BookDetailViewState, Never> = .init()
    
    var items: [BookDetailControllerSectionType]  = [
        .BookInfoSection,
        .BookActionSection,
        .AboutBookSection,
        .RatingAndReviewsSection,
        .CommentList(comments: [
            CommentListItem(name: "Stavven Gomez", comments: [CommentListItem.Comment]()),
            CommentListItem(name: "Stavven Gomez", comments: [CommentListItem.Comment]()),
            CommentListItem(name: "Stavven Gomez", comments: [CommentListItem.Comment]()),
            CommentListItem(name: "Stavven Gomez", comments: [CommentListItem.Comment]()),
        ])
    ]
    
    private var cancellable = Set<AnyCancellable>()
    
    private let bookModel: BookModel = BookModelImpl.shared
    
    var book: BookObject!
    
    init(book: BookObject) {
        
        self.book = book
        
        bookModel.addBookToRecent(data: self.book)
    }
    
    func addToWishList() {
        if bookModel.addToWishList(data: book) {
            viewState.send(.addToWishList)
        } else {
            viewState.send(.failure(message: "Something went wrong while adding to wish list."))
        }
    }
    
    func deleteFromWishList() {
        if bookModel.deleteFromWishList(data: book) {
            viewState.send(.deleteFromLibrary)
        } else {
            viewState.send(.failure(message: "Something went wrong while deleting from wish list."))
        }
    }
    
    func isBookInWishList() -> Bool {
        return bookModel.isBookInWishList(data: book)
    }
    
    func getSectionCount() -> Int {
        return items.count
    }
    
    func getRowCountBySection(section: Int) -> Int {
        switch items[section] {
        case .CommentList(let comments):
            return comments.count
            
        default:
            return 1
        }
    }
    
    func getItemTypeByIndex(index: Int) -> BookDetailControllerSectionType {
        return items[index]
    }
    
    func getBook() -> BookObject {
        return book
    }
    
    func getBookDescription() -> String {
        return book.bookDescription
    }
    
    
}

