//
//  MockNetworkAgent.swift
//  GooglePlayBooksTests
//
//  Created by Ye linn htet on 7/27/22.
//

import Foundation
@testable import GooglePlayBooks
import Alamofire
import Combine

class MockNetworkAgent {
    
    func getBooksBySearch(query: String) -> AnyPublisher<BookSearchResponse, AFError> {
        return AF.request("https://www.googleapis.com/books/v1/volumes?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")").publishDecodable(type: BookSearchResponse.self).value()
    }
    
}
