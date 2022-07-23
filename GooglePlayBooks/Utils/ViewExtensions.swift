//
//  ViewExtensions.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/28/22.
//

import Foundation
import UIKit


extension UITableViewCell {
    static var identifier : String {
        String(describing: self)
    }
}

extension UITableView {
    
    func registerForCell(identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell<T:UITableViewCell>(identifier:String, indexPath: IndexPath)->T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            return UITableViewCell() as! T
        }
        return cell
    }
    
}

extension UICollectionViewCell {
    static var identifier : String {
        String(describing: self)
    }
}

extension UICollectionView {
    
    func registerForCell(identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueCell<C:UICollectionViewCell>(identifier:String, indexPath: IndexPath)->C {
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? C else {
            return UICollectionViewCell() as! C
        }
        return cell
    }
}


extension UIViewController {
    static var identifier : String {
        String(describing: self)
    }
}

extension UITextField {
    func setUpUnderline() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor(named: "colorPrimary")?.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
