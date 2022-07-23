//
//  SearchViewModel.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/20/22.
//

import Foundation
import Combine

enum SearchViewState {

    case success
    
    case failure
    
}

class SearchViewModel {
    
    var viewState: PassthroughSubject<SearchViewState, Never> = .init()
    
    private var bookList = [BookObject]()
    
    private var cancellable = Set<AnyCancellable>()
    
    private let searchModel: SearchModel = SearchModelImpl.shared
    
    
    func searchBooksByName(query: String) {
        searchModel.getBooksBySearch(query: query).sink { [weak self] data in
            guard let self = self else { return }
            self.bookList = data
            debugPrint(self.bookList.count)
            self.viewState.send(.success)
            
        }.store(in: &cancellable)
        
    }
    
    
    func getBookCount() -> Int {
        return bookList.count
    }
    
    func getBookByIndex(_ index: Int) -> BookObject {
        return bookList[index]
    }
    
}
