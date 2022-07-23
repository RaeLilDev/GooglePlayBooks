//
//  AddToShelfTableViewCell.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/9/22.
//

import UIKit

class AddToShelfTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCheckMark: UIButton!
    @IBOutlet weak var shelfName: UILabel!
    @IBOutlet weak var bookCount: UILabel!
    @IBOutlet weak var ivShelfImage: UIImageView!
    
    var data: ShelfObject? {
        didSet {
            if let data = data {
                shelfName.text = data.shelfName
                let count = data.books.count
                if count > 1 {
                    bookCount.text = "\(count) Books"
                } else {
                    bookCount.text = "\(count) Book"
                }
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            btnCheckMark.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            btnCheckMark.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    
}
