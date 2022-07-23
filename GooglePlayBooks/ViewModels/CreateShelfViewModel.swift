//
//  CreateShelfViewModel.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/21/22.
//

import Foundation
import Combine

enum CreateShelfViewState {

    case addShelfSuccess
    
    case renameShelfSuccess
    
    case failure(message: String)
    
}

class CreateShelfViewModel {
    
    var viewState: PassthroughSubject<CreateShelfViewState, Never> = .init()
    
    private var cancellable = Set<AnyCancellable>()
    
    private let shelfModel: ShelfModel = ShelfModelImpl.shared
    
    var shelf: ShelfObject!
    
    var isRename = false
    
    init(shelf: ShelfObject, isRename: Bool) {
        self.shelf = shelf
        self.isRename = isRename
    }
    
    init(isRename: Bool) {
        self.isRename = isRename
    }
    
    func createShelf(with shelfName: String) {
        if shelfModel.addShelf(name: shelfName) {
            viewState.send(.addShelfSuccess)
        } else {
            viewState.send(.failure(message: "Something went wrong while adding shelf."))
        }
        
    }
    
    func renameShelf(with shelfName: String) {
        if shelfModel.renameShelf(name: shelfName, shelf: shelf) {
            viewState.send(.renameShelfSuccess)
        } else {
            viewState.send(.failure(message: "Something went wrong while renaming shelf."))
        }
    }
    
    func getShelfName() -> String {
        return shelf.shelfName
    }
    
    
}
