//
//  MockShelfModel.swift
//  GooglePlayBooksTests
//
//  Created by Ye linn htet on 7/28/22.
//

import Foundation
import Combine
import Alamofire
@testable import GooglePlayBooks

class MockShelfModel: ShelfModel {
    
    let shelfRepository: ShelfRepository = ShelfRepositoryImpl.shared
    
    var isFailure = false
    
    func getAllShelves() -> AnyPublisher<[ShelfObject], Never> {
        if isFailure {
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        return shelfRepository.getShelfList()
    }
    
    func addShelf(name: String) -> Bool {
        return shelfRepository.addShelf(data: shelfNameToShelfObject(name: name))
    }
    
    func addBookToShelf(book: BookObject, shelf: ShelfObject) -> Bool {
        return shelfRepository.addBookToShelf(book: book, shelf: shelf)
    }
    
    func renameShelf(name: String, shelf: ShelfObject) -> Bool {
        return shelfRepository.renameShelf(data: shelf, shelfName: name)
    }
    
    func getShelfBooks(by attribute: String, order: Bool, shelfId: String) -> AnyPublisher<[BookObject], Never> {
        return shelfRepository.getShelfBooks(by: attribute, order: order, shelfId: shelfId)
    }
    
    func getShelf(shelf: ShelfObject) -> AnyPublisher<ShelfObject, Never> {
        return shelfRepository.getShelf(shelf: shelf)
    }
    
    func deleteShelf(shelf: ShelfObject) -> Bool {
        return shelfRepository.deleteShelf(shelf: shelf)
    }
    
    func shelfNameToShelfObject(name: String) -> ShelfObject {
        let object = ShelfObject()
        object.id = UUID().uuidString
        object.shelfName = name
        object.shelfImage = ""
        return object
    }
    
    
}
