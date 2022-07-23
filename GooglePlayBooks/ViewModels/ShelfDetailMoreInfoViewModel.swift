//
//  ShelfDetailMoreInfoViewModel.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/23/22.
//

import Foundation
import Combine

enum ShelfDetailMoreInfoViewState {

    
    case successDelete
    
    case failure(message: String)
    
}


class ShelfDetailMoreInfoViewModel {
    
    
    
    var viewState: PassthroughSubject<ShelfDetailMoreInfoViewModel, Never> = .init()
    
    private var cancellable = Set<AnyCancellable>()
    
    private let shelfModel: ShelfModel = ShelfModelImpl.shared
    
    var shelf: ShelfObject!
    
    init(shelf: ShelfObject) {
        self.shelf = shelf
    }
    
    func getShelfName() -> String {
        return shelf.shelfName
    }
    
}
