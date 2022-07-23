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
    
    private var cancellable = Set<AnyCancellable>()
    
    private let bookModel: BookModel = BookModelImpl.shared
    
    private let shelfModel: ShelfModel = ShelfModelImpl.shared
    
    private var shelfList = [ShelfObject]()
    
    private var bookList = [BookObject]()
    
    
    func fetchWishList(by attribute: String, order: Bool) {
        bookModel.getWishList(by: attribute, order: order)
            .sink { error in
                self.viewState.send(.failure(message: "Something went wrong "))
            } receiveValue: { data in
                self.bookList = data
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
            self.viewState.send(.failure(message: "Something went wrong while fetching shelves"))
        } receiveValue: { [weak self] data in
            guard let self = self else { return }
            debugPrint("Fetch Shelves working in viewmodel")
            if data.count == 0 {
                self.viewState.send(.noShelveExist)
            } else {
                self.shelfList = data
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
