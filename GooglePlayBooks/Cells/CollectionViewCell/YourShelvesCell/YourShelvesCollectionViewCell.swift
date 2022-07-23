//
//  YourShelvesCollectionViewCell.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/10/22.
//

import UIKit

class YourShelvesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblShelfName: UILabel!
    @IBOutlet weak var lblBookCount: UILabel!
    @IBOutlet weak var ivShelfImage: UIImageView!
    
    var data: ShelfObject? {
        didSet {
            if let data = data {
                lblShelfName.text = data.shelfName
                let count = data.books.count
                if count > 1 {
                    lblBookCount.text = "\(count) Books"
                } else {
                    lblBookCount.text = "\(count) Book"
                }
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
