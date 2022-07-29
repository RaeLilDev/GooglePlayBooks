//
//  LibraryViewModel.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/20/22.
//

import Foundation
import Combine

enum LibraryViewState {

    case wishList
    
    case fetchShelvesSuccess
    
    case noShelveExist
    
    case failure(message: String)
    
    
}

class LibraryViewModel {
    
    var viewState: PassthroughSubject<LibraryViewState, Never> = .init()
    
    var testViewState: CurrentValueSubject<LibraryViewState, Never> = .init(.failure(message: ""))
    
    private var cancellable = Set<AnyCancellable>()
    
    private var bookModel: BookModel = BookModelImpl.shared
    
    private var shelfModel: ShelfModel = ShelfModelImpl.shared
    
    private var shelfList = [ShelfObject]()
    
    private var bookList = [BookObject]()
    
    
    init() {}
    
    init(bookModel: BookModel, shelfModel: ShelfModel) {
        self.bookModel = bookModel
        self.shelfModel = shelfModel
    }
    
    func fetchWishList(by attribute: String, order: Bool) {
        bookModel.getWishList(by: attribute, order: order)
            .sink { error in
                self.testViewState.send(.failure(message: "Something went wrong "))
                self.viewState.send(.failure(message: "Something went wrong "))
            } receiveValue: { data in
                self.bookList = data
                self.testViewState.send(.wishList)
                self.viewState.send(.wishList)
            }.store(in: &cancellable)
    }
    
    func getBookList() -> [BookObject] {
        return bookList
    }
    
    func getBookListCount() -> Int {
        return bookList.count
    }
    
    func getBookByIndex(index: Int) -> BookObject {
        return bookList[index]
    }
    
    func fetchAllSheves() {
        
        shelfModel.getAllShelves().sink { [weak self] _ in
            guard let self = self else { return }
            self.testViewState.send(.failure(message: "Something went wrong while fetching shelves"))
            self.viewState.send(.failure(message: "Something went wrong while fetching shelves"))
        } receiveValue: { [weak self] data in
            guard let self = self else { return }
            
            self.shelfList = data
            
            if data.count == 0 {
                self.testViewState.send(.noShelveExist)
                self.viewState.send(.noShelveExist)
            } else {
                self.testViewState.send(.fetchShelvesSuccess)
                self.viewState.send(.fetchShelvesSuccess)
            }
            
        }.store(in: &cancellable)
        
    }
    
    func getShelvesList() -> [ShelfObject] {
        return shelfList
    }
    
    func getShelvesCount() -> Int {
        return shelfList.count
    }
    
    func getShelfByIndex(index: Int) -> ShelfObject {
        return shelfList[index]
    }
    
}
