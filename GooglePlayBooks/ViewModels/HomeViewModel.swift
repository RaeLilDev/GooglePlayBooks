//
//  HomeViewModel.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/20/22.
//

import Foundation
import Combine

enum HomeViewState {

    case success
    
    case failure
    
}

class HomeViewModel {
    
    var viewState: PassthroughSubject<HomeViewState, Never> = .init()
    
    private var items: [HomeViewControllerSectionType]  = [
        .RecentlyOpenedItems(items: []),
        .CategorySelection,
        .ItemList(items: [])
    ]
    
    private let bookModel: BookModel = BookModelImpl.shared
    
    private var anyCancellable = Set<AnyCancellable>()
    
    func getAllBooks() {
        
        Publishers.CombineLatest(bookModel.getAllBookLists(), bookModel.getRecentList())
            .sink { [weak self] error in
                guard let self = self else { return }
                self.viewState.send(.failure)
            } receiveValue: { [weak self] (listData, recentData) in
                guard let self = self else { return }
                
                self.items[2] = .ItemList(items: listData)
                self.items[0] = .RecentlyOpenedItems(items: recentData)

                self.viewState.send(.success)
                
            }.store(in: &anyCancellable)

    }
    
    
    func getSectionCount() -> Int {
        return items.count
    }
    
    func getNumberOfRowsInSection(_ section: Int) -> Int {
        switch items[section] {
        case .ItemList(let items):
            return items.count
            
        case .RecentlyOpenedItems(let items):
            return items.count > 0  ? 1 : 0
            
        default:
            return 1
        }
    }
    
    func getItems(_ section: Int) -> HomeViewControllerSectionType {
        return items[section]
    }
    
}
