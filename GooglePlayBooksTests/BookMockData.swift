//
//  BookMockData.swift
//  GooglePlayBooksTests
//
//  Created by Ye linn htet on 7/27/22.
//

import Foundation

public final class BookMockData {
    
    class AllList {
        public static let AllListJSONURL: URL = Bundle(for: BookMockData.self).url(forResource: "all_list", withExtension: "json")!
    }
    
    class SearchResult {
        public static let SearchResultJSONURL: URL = Bundle(for: BookMockData.self).url(forResource: "search_books_by_name", withExtension: "json")!
        
        static let corruptResponseURL: URL = Bundle(for: BookMockData.self).url(forResource: "corrupt_response", withExtension: "html")!
    }
    
}
