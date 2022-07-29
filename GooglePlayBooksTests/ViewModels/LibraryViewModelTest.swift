//
//  ShelfViewModelTest.swift
//  GooglePlayBooksTests
//
//  Created by Ye linn htet on 7/28/22.
//

import XCTest
@testable import GooglePlayBooks
import Combine


class LibraryViewModelTest: XCTestCase {
    
    var viewModel: LibraryViewModel!
    var bookModel: MockBookModel!
    var shelfModel: MockShelfModel!
    
    var cancellable: Set<AnyCancellable>!

    override func setUpWithError() throws {
        bookModel = MockBookModel()
        shelfModel = MockShelfModel()
        viewModel = LibraryViewModel(bookModel: bookModel, shelfModel: shelfModel)
        cancellable = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        bookModel = nil
        shelfModel = nil
        viewModel = nil
        cancellable = nil
    }
    
    func test_fetchWishList_withValidData_ShouldReturnAllWishLists() throws {
        
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.fetchWishList(by: "date", order: false)
        
        let _ = bookModel.addToWishList(data: BookObject())
        
        viewModel.testViewState
            .sink(receiveValue: { state in
                if case .wishList = state {
                    XCTAssertEqual(self.viewModel.getBookListCount(), 0)
                    responseExpectation.fulfill()
                }
            }).store(in: &cancellable)
        
        wait(for: [responseExpectation], timeout: 5)
    }
    
    
    func test_fetchAllShelves_withNoData_shouldReturnNoData() throws {
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.fetchAllSheves()
        
        viewModel.testViewState
            .sink(receiveValue: { state in
                if case .noShelveExist = state {
                    XCTAssertEqual(self.viewModel.getShelvesCount(), 0)
                    responseExpectation.fulfill()
                }
                
            }).store(in: &cancellable)
        
        wait(for: [responseExpectation], timeout: 5)
    }
    
    
    func test_fetchAllShelves_withValidData_shouldReturnAllShelves() throws {
        
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.fetchAllSheves()
        
        let _ = shelfModel.addShelf(name: "My Shelf")
        
        viewModel.testViewState
            .sink(receiveValue: { state in
                if case .fetchShelvesSuccess = state {
                    XCTAssertEqual(self.viewModel.getShelvesCount(), 1)
                    responseExpectation.fulfill()
                }
            }).store(in: &cancellable)
        
        wait(for: [responseExpectation], timeout: 5)
    }
    
    func test_fetchAllShelves_withSomeError_shouldFailWithError() throws {
        
        let responseExpectation = expectation(description: "wait for response")
        
        shelfModel.isFailure = true
        
        viewModel.fetchAllSheves()
        
        viewModel.testViewState
            .sink(receiveValue: { state in
                if case .failure(_) = state {
                    responseExpectation.fulfill()
                }
            }).store(in: &cancellable)
        
        wait(for: [responseExpectation], timeout: 5)
    }
    
    
    func test_fetchAllWishList_withSomeError_shouldFailWithError() throws {
        let responseExpectation = expectation(description: "wait for response")
        
        bookModel.isFailure = true
        
        viewModel.fetchWishList(by: "date", order: false)
        
        viewModel.testViewState
            .sink(receiveValue: { state in
                if case .failure(_) = state {
                    responseExpectation.fulfill()
                }
            }).store(in: &cancellable)
        
        wait(for: [responseExpectation], timeout: 5)
    }
    
    


}
