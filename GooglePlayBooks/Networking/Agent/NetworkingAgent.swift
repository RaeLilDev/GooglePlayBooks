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
    
    private init() {}
    
    func getBookListsOverview() -> AnyPublisher<BookListResponse, AFError> {
        
        return AF.request(GPBEndpoint.bookListsOverview).publishDecodable(type: BookListResponse.self).value()
        
    }
    
    func getBooksByList(listName: String) -> AnyPublisher<MoreBookResponse, AFError> {
        
        return AF.request(GPBEndpoint.bookByList(listName)).publishDecodable(type: MoreBookResponse.self).value()
        
    }
    
    func getBooksBySearch(query: String) -> AnyPublisher<BookSearchResponse, AFError> {
        return AF.request("https://www.googleapis.com/books/v1/volumes?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")").publishDecodable(type: BookSearchResponse.self).value()
    }
}


