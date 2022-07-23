//
//  OnTapHomeBookItemDelegate.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/12/22.
//

import Foundation

protocol OnTapHomeBookItemDelegate {
    
    func didTapBookItem(item: BookObject)
    
    func didTapBookMoreInfo(item: BookObject)
    
    func didTapViewMore(item: ListObject)
    
    func didTapAddToShelves(item: BookObject)
}
