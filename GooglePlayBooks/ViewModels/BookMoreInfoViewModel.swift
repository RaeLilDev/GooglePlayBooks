//
//  BookMoreInfoViewModel.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/20/22.
//

import Foundation
import Combine

enum MoreInfoViewState {

    case addToWishList
    
    case deleteFromLibrary
    
    case addToShelves
    
    case failure(message: String)
    
    
}

class BookMoreInfoViewModel {
    
    var viewState: PassthroughSubject<MoreInfoViewState, Never> = .init()
    
    private var cancellable = Set<AnyCancellable>()
    
    private let bookModel: BookModel = BookModelImpl.shared
    
    var book: BookObject!
    
    init(book: BookObject) {
        
        self.book = book
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
    
    
    
    func getBook() -> BookObject {
        return book
    }
    
    
    
    
}
