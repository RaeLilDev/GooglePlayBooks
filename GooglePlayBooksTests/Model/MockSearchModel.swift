//
//  MockSearchModel.swift
//  GooglePlayBooksTests
//
//  Created by Ye linn htet on 7/27/22.
//

import Foundation
import Combine
@testable import GooglePlayBooks

class MockSearchModel: SearchModel {
    
    func getBooksBySearch(query: String) -> AnyPublisher<[BookObject], Never> {
        
        let mockedDataFromJSON = try! Data(contentsOf: BookMockData.SearchResult.SearchResultJSONURL)
        
        let responseData = try! JSONDecoder().decode(BookSearchResponse.self, from: mockedDataFromJSON)
        
        let subject = CurrentValueSubject<[BookObject], Never>([])
        
        let bookList = responseData.items.map { $0.map { $0.toBookObject() } } ?? [BookObject]()
        
        subject.send(bookList)
        
        return subject.eraseToAnyPublisher()
    }
    
    
}
