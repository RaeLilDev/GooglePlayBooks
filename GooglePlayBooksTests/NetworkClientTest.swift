//
//  NetworkClientTest.swift
//  GooglePlayBooksTests
//
//  Created by Ye linn htet on 7/27/22.
//

import XCTest
@testable import GooglePlayBooks
import Alamofire
import Mocker
import Combine

class NetworkClientTest: XCTestCase {

    var networkClient = NetworkAgent.shared
    
    var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        //Init Mock
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        //Setting up dependency
        let sessionManager = Session(configuration: configuration)
        networkClient.sessionManager = sessionManager
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_searchBook_successWithValidResponse_returnsCorrectData() throws {
        
        //Prepare mock data
        let query: String = "flutter"
        let apiEndpoint = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!
        
        let searchBookExpectation = expectation(description: "wait for search movie")
        
        //Load Data from json file
        let mockedDataFromJSON = try! Data(contentsOf: BookMockData.SearchResult.SearchResultJSONURL)
        
        let mock = Mock(
            url: apiEndpoint,
            dataType: .json,
            statusCode: 200,
            data: [.get: mockedDataFromJSON])
        
        mock.register()
        
        networkClient.getBooksBySearch(query: query).sink { _ in
            debugPrint("Error Occured")
        } receiveValue: { response in
            XCTAssertGreaterThan(response.items?.count ?? 0, 0)
            searchBookExpectation.fulfill()
        }.store(in: &cancellable)
        
        wait(for: [searchBookExpectation], timeout: 5)
        
    }
    
    func test_searchBook_withCorruptResponseURL_shouldFailWithError() throws {
        //Prepare mock data
        let query: String = "flutter"
        let apiEndpoint = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!
        
        let searchBookExpectation = expectation(description: "wait for search movie")
        
        //Load Data from json file
        let mockedDataFromJSON = try! Data(contentsOf: BookMockData.SearchResult.corruptResponseURL)
        
        let mock = Mock(
            url: apiEndpoint,
            dataType: .json,
            statusCode: 200,
            data: [.get: mockedDataFromJSON])
        
        mock.register()
        
        networkClient.getBooksBySearch(query: query).sink { _ in
            debugPrint("Error Occured")
            searchBookExpectation.fulfill()
        } receiveValue: { response in
            debugPrint("Should not success")
        }.store(in: &cancellable)
        
        wait(for: [searchBookExpectation], timeout: 5)
    }

}
