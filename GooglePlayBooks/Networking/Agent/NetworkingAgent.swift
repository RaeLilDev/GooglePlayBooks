//
//  NetworkingAgent.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/13/22.
//

import Foundation
import Alamofire
import Combine

class NetworkAgent {
    
    static let shared = NetworkAgent()
    
    var sessionManager: Session = AF
    
    private init() {}
    
    func getBookListsOverview() -> AnyPublisher<BookListResponse, AFError> {
        
        return sessionManager.request(GPBEndpoint.bookListsOverview).publishDecodable(type: BookListResponse.self).value()
        
    }
    
    func getBooksByList(listName: String) -> AnyPublisher<MoreBookResponse, AFError> {
        
        return sessionManager.request(GPBEndpoint.bookByList(listName)).publishDecodable(type: MoreBookResponse.self).value()
        
    }
    
    func getBooksBySearch(query: String) -> AnyPublisher<BookSearchResponse, AFError> {
        return sessionManager.request("https://www.googleapis.com/books/v1/volumes?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")").publishDecodable(type: BookSearchResponse.self).value()
    }
}


