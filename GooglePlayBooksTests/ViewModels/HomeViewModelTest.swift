//
//  HomeViewModelTest.swift
//  GooglePlayBooksTests
//
//  Created by Ye linn htet on 7/27/22.
//

import XCTest
@testable import GooglePlayBooks
import Combine

class HomeViewModelTest: XCTestCase {

    var viewModel: HomeViewModel!
    var bookModel: MockBookModel!
    
    var cancellable: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
    
        bookModel = MockBookModel()
        viewModel = HomeViewModel(bookModel: bookModel)
        
        cancellable = Set<AnyCancellable>()
        
    }

    override func tearDownWithError() throws {
        bookModel = nil
        viewModel = nil
    }

    
    func test_fetchAllBookList_withValidData_ShouldReturnAllLists() throws {
        
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.getAllBooks()
        
        bookModel.addBookToRecent(data: BookObject())
        
        viewModel.testViewState
            .sink(receiveValue: { state in
                debugPrint("State is working \(state)")
                if case .success = state {
                    XCTAssertGreaterThan(self.viewModel.getNumberOfRowsInSection(2), 4)
                    XCTAssertGreaterThan(self.viewModel.getNumberOfRowsInSection(0), 0)
                    responseExpectation.fulfill()
                }
            }).store(in: &cancellable)
        
        wait(for: [responseExpectation], timeout: 10)
    }
    
    func test_fetchAllBookList_withError_shouldFailWithError() throws {
        let responseExpectation = expectation(description: "wait for response")
        
        bookModel.isFailure = true
        viewModel.getAllBooks()
        
        viewModel.testViewState
            .sink(receiveValue: { state in
                debugPrint("State is working \(state)")
                if case .failure = state {
                    responseExpectation.fulfill()
                }
            }).store(in: &cancellable)
        
        wait(for: [responseExpectation], timeout: 10)
    }

}
