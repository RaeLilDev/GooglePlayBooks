//
//  ShelfDetailViewModel.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/23/22.
//

import Foundation
import Combine

enum ShelfDetailViewState {

    
    case successFetchingShelfBooks
    
    case shelfUpdate
    
    case shelfDelete
    
    case failure(message: String)
    
}


class ShelfDetailViewModel {
    
    var viewState: PassthroughSubject<ShelfDetailViewState, Never> = .init()
    
    private var bookList: [BookObject]  = []
    
    private var cancellable = Set<AnyCancellable>()
    
    private let shelfModel: ShelfModel = ShelfModelImpl.shared
    
    var shelf: ShelfObject!
    
    
    init(shelf: ShelfObject) {
        self.shelf = shelf
    }
    
    func getShelfBooks(by attribute: String, order: Bool) {
        shelfModel.getShelfBooks(by: attribute, order: order, shelfId: shelf.id).sink { error in
            self.viewState.send(.failure(message: "Something went wrong while fetching shelf books."))
        } receiveValue: { data in
            self.bookList = data
            self.viewState.send(.successFetchingShelfBooks)
        }.store(in: &cancellable)

    }
    
    func getShelf() {
        shelfModel.getShelf(shelf: shelf).sink { data in
            self.shelf = data
            self.viewState.send(.shelfUpdate)
        }.store(in: &cancellable)
    }
    
    func deleteShelf() {
        if shelfModel.deleteShelf(shelf: shelf) {
            self.viewState.send(.shelfDelete)
        } else {
            self.viewState.send(.failure(message: "Error while deleting shelf"))
        }
    }
    
    
    func getShelfName() -> String {
        return shelf.shelfName
    }
    
    func getShelfBookCount() -> Int {
        return shelf.books.count
    }
    
    func getBookList() -> [BookObject] {
        return bookList
    }
    
    func getBookByIndex(index: Int) -> BookObject {
        return bookList[index]
    }
    
    func getBookCount() -> Int {
        return bookList.count
    }
 
    
}
