//
//  Router.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/6/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func navigateToCreateShelfViewController(isRename: Bool) {
        let vc = CreateShelfViewController()
        vc.viewModel = CreateShelfViewModel(isRename: isRename)
        self.navigationItem.backButtonTitle = "Back"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToCreateShelfViewController(shelf: ShelfObject, isRename: Bool) {
        let vc = CreateShelfViewController()
        vc.viewModel = CreateShelfViewModel(shelf: shelf, isRename: true)
        self.navigationItem.backButtonTitle = "Back"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToShelfDetailViewController(shelf: ShelfObject) {
        let vc = ShelfDetailViewController()
        self.navigationItem.backButtonTitle = "Back"
        vc.viewModel = ShelfDetailViewModel(shelf: shelf)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAddToShelvesViewController() {
        let vc = AddToShelvesViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAboutThisBookViewController(book: BookObject) {
        let vc = BookDetailViewController()
        vc.viewModel = BookDetailViewModel(book: book)
        self.navigationItem.backButtonTitle = "Back"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToSearchViewController() {
        let vc = SearchViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToViewMoreViewController(listItem: ListObject) {
        let vc = ViewMoreViewController()
        vc.selectedList = listItem
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func navigateToAddToShelvesViewController(book: BookObject) {
        let vc = AddToShelvesViewController()
        vc.viewModel = AddToShelvesViewModel(book: book)
        self.navigationItem.backButtonTitle = "Back"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
