//
//  AddToShelvesViewModel.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/21/22.
//

import Foundation
import Combine

enum AddToShelfViewState {

    case fetchShelvesSuccess
    
    case noShelveExist
    
    case addToShelfSuccess
    
    case addToShelfFail
    
    case failure(message: String)
    
}

class AddToShelvesViewModel {
    
    var viewState: PassthroughSubject<AddToShelfViewState, Never> = .init()
    
    
    private var cancellable = Set<AnyCancellable>()
    
    private let shelfModel: ShelfModel = ShelfModelImpl.shared
    
    var shelfList = [ShelfObject]()
    
    var book: BookObject!
    
    init(book: BookObject) {
        self.book = book
    }
    
    
    func fetchAllSheves() {
        
        shelfModel.getAllShelves().sink { [weak self] _ in
            guard let self = self else { return }
            self.viewState.send(.failure(message: "Something went wrong while fetching shelves"))
        } receiveValue: { [weak self] data in
            guard let self = self else { return }
            if data.count == 0 {
                self.viewState.send(.noShelveExist)
            } else {
                self.shelfList = data
                self.viewState.send(.fetchShelvesSuccess)
            }
            
        }.store(in: &cancellable)

    }
    
    
    func addBookToShelf(by index: Int) {
        let valid = shelfModel.addBookToShelf(book: book, shelf: getShelfByIndex(index: index))
        
        if valid {
            viewState.send(.addToShelfSuccess)
        } else {
            viewState.send(.addToShelfFail)
        }
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



