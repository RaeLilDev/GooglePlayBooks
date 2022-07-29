//
//  SearchViewModelTest.swift
//  GooglePlayBooksTests
//
//  Created by Ye linn htet on 7/27/22.
//

import XCTest
@testable import GooglePlayBooks
import Combine

class SearchViewModelTest: XCTestCase {

    var viewModel: SearchViewModel!
    var searchModel: MockSearchModel!
    
    var cancellable: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        
        searchModel = MockSearchModel()
        viewModel = SearchViewModel(searchModel: searchModel)
        
        cancellable = Set<AnyCancellable>()
        
    }

    override func tearDownWithError() throws {
        searchModel = nil
        viewModel = nil
    }

    
    func test_search_withValidData_shouldReturnSearchResults() throws {
        
        let responseExpectation = expectation(description: "wait for response")
        
        
        viewModel.searchBooksByName(query: "flutter")
            
        viewModel.testViewState
            .sink(receiveValue: { state in
                debugPrint("State is working \(state)")
                if case .success = state {
                    XCTAssertGreaterThan(self.viewModel.getBookCount(), 0)
                    responseExpectation.fulfill()
                }
            }).store(in: &cancellable)
        
        wait(for: [responseExpectation], timeout: 10)
    }
    
    
    

}
