//
//  MockBookModel.swift
//  GooglePlayBooksTests
//
//  Created by Ye linn htet on 7/27/22.
//

import Foundation
import Combine
import Alamofire
@testable import GooglePlayBooks

class MockBookModel: BookModel {
    
    let bookRepository: BookRepository = BookRepositoryImpl.shared
    
    var isFailure = false
    
    func getAllBookLists() -> AnyPublisher<[ListObject], Never> {
        
        if isFailure {
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        
        let mockedDataFromJSON = try! Data(contentsOf: BookMockData.AllList.AllListJSONURL)
        
        let responseData = try! JSONDecoder().decode(BookListResponse.self, from: mockedDataFromJSON)
        
        let listVOs = responseData.results?.lists?.map { $0.toListObject() } ?? [ListObject]()

        let subject = CurrentValueSubject<[ListObject], Never>([])
        subject.send(listVOs)
        
        return subject.eraseToAnyPublisher()
        
    }
    
    func addBookToRecent(data: BookObject) {
        bookRepository.addBookToRecent(data: data)
    }
    
    func getRecentList() -> AnyPublisher<[BookObject], Never> {
        if isFailure {
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        
        return bookRepository.getRecentList()
    }
    
    func getBookByList(listName: String, id: Int) -> AnyPublisher<[BookObject], Never> {
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }
    
    
    func addToWishList(data: BookObject) -> Bool {
        return bookRepository.addToWishList(data: data)
    }
    
    func isBookInWishList(data: BookObject) -> Bool {
        return true
    }
    
    func deleteFromWishList(data: BookObject) -> Bool {
        return true
    }
    
    func getWishList(by attribute: String, order: Bool) -> AnyPublisher<[BookObject], Never> {
        
        if isFailure {
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        
        return bookRepository.getWishList(by: attribute, order: order)
    }
    
    
}
