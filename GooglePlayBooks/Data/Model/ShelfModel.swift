//
//  ShelfModel.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/21/22.
//

import Foundation
import Combine

protocol ShelfModel {
    
    func getAllShelves() -> AnyPublisher<[ShelfObject], Never>
    
    func addShelf(name: String) -> Bool
    
    func addBookToShelf(book: BookObject, shelf: ShelfObject) -> Bool
    
    func renameShelf(name: String, shelf: ShelfObject) -> Bool
    
    func getShelfBooks(by attribute: String, order: Bool, shelfId: String) -> AnyPublisher<[BookObject], Never>
    
    func getShelf(shelf: ShelfObject) -> AnyPublisher<ShelfObject, Never>
    
    func deleteShelf(shelf: ShelfObject) -> Bool
}

class ShelfModelImpl: BaseModel, ShelfModel {
    
    private let shelfRepository: ShelfRepository = ShelfRepositoryImpl.shared
    
    static let shared = ShelfModelImpl()
    
    private var cancellable = Set<AnyCancellable>()
    
    private override init() { }
    
    
    func getAllShelves() -> AnyPublisher<[ShelfObject], Never> {
        return shelfRepository.getShelfList()
    }
    
    
    func addShelf(name: String) -> Bool {
        return shelfRepository.addShelf(data: shelfNameToShelfObject(name: name))
    }
    
    func renameShelf(name: String, shelf: ShelfObject) -> Bool {
        return shelfRepository.renameShelf(data: shelf, shelfName: name)
    }
    
    func addBookToShelf(book: BookObject, shelf: ShelfObject) -> Bool {
        return shelfRepository.addBookToShelf(book: book, shelf: shelf)
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
