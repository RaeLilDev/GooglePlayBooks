//
//  BookModel.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/14/22.
//

import Foundation
import Combine

protocol BookModel {
    
    func getAllBookLists() -> AnyPublisher<[ListObject], Never>
    
    func addBookToRecent(data: BookObject)
    
    func getRecentList() -> AnyPublisher<[BookObject], Never>
    
    func getBookByList(listName: String, id: Int) -> AnyPublisher<[BookObject], Never>
    
    func addToWishList(data: BookObject) -> Bool
    
    func isBookInWishList(data: BookObject) -> Bool
    
    func deleteFromWishList(data: BookObject) -> Bool
    
    func getWishList(by attribute: String, order: Bool) -> AnyPublisher<[BookObject], Never>
}

class BookModelImpl: BaseModel, BookModel {
    
    private let bookRepository: BookRepository = BookRepositoryImpl.shared
    
    static let shared = BookModelImpl()
    
    private var cancellable = Set<AnyCancellable>()
    
    private override init() { }
    
    
    func getAllBookLists() -> AnyPublisher<[ListObject], Never> {
        let observableRemoteBookList = networkAgent.getBookListsOverview()
        
        observableRemoteBookList
            .sink { error in
                debugPrint(error)
            } receiveValue: { data in
                self.bookRepository.saveList(data: data)
            }.store(in: &cancellable)
        
        return bookRepository.getLists()
    }
    
    
    func addBookToRecent(data: BookObject) {
        bookRepository.addBookToRecent(data: data)
    }
    
    
    func getRecentList() -> AnyPublisher<[BookObject], Never> {
        return bookRepository.getRecentList()
    }
    
    func getBookByList(listName: String, id: Int) -> AnyPublisher<[BookObject], Never> {
        let observableRemoteBookList = networkAgent.getBooksByList(listName: listName)
        
        observableRemoteBookList
            .sink { error in
                debugPrint(error)
            } receiveValue: { data in
                self.bookRepository.saveBooksInList(with: id, data: data)
            }.store(in: &cancellable)
        
        return bookRepository.getBooksByList(with: id)
    }
    
    func getBooksBySearch(query: String) -> AnyPublisher<[BookObject], Never> {
        
        let observableRemoteBookList = networkAgent.getBooksBySearch(query: query)
        
        let subject = CurrentValueSubject<[BookObject], Never>([])
        
        observableRemoteBookList.sink { _ in
            debugPrint("Something went wrong")
        } receiveValue: { data in
            let bookList = data.items.map { $0.map { $0.toBookObject() } } ?? [BookObject]()
            subject.send(bookList)
        }.store(in: &cancellable)
        
        return subject.eraseToAnyPublisher()
        
        
    }
    
    
    func addToWishList(data: BookObject) -> Bool {
        bookRepository.addToWishList(data: data)
    }
    
    func isBookInWishList(data: BookObject) -> Bool {
        
        let data = bookRepository.isBookInWishList(data: data)
        return data
    }
    
    func deleteFromWishList(data: BookObject) -> Bool {
        bookRepository.deleteFromWishList(data: data)
    }
    
    
    func getWishList(by attribute: String, order: Bool) -> AnyPublisher<[BookObject], Never> {
        return bookRepository.getWishList(by: attribute, order: order)
    }
    
}
