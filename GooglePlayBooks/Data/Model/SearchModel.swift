//
//  SearchModel.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/18/22.
//

import Foundation

import Combine

protocol SearchModel {
    
    func getBooksBySearch(query: String) -> AnyPublisher<[BookObject], Never>
}

class SearchModelImpl: BaseModel, SearchModel {
    
    static let shared = SearchModelImpl()
    
    private var cancellable = Set<AnyCancellable>()
    
    private override init() { }
  
    
    func getBooksBySearch(query: String) -> AnyPublisher<[BookObject], Never> {
        
        let observableRemoteBookList = networkAgent.getBooksBySearch(query: query)
        
        let subject = CurrentValueSubject<[BookObject], Never>([])
        
        observableRemoteBookList.sink { error in
            debugPrint(error)
            debugPrint("Something went wrong")
        } receiveValue: { data in
            let bookList = data.items.map { $0.map { $0.toBookObject() } } ?? [BookObject]()
            subject.send(bookList)
        }.store(in: &cancellable)
        
        return subject.eraseToAnyPublisher()
        
        
    }
    
}
