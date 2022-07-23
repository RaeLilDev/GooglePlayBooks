//
//  SearchResultTableViewCell.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/10/22.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var ivBook: UIImageView!
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    
    var data: BookObject? {
        didSet {
            if let data = data {
                ivBook.sd_setImage(with: URL(string: data.bookImage))
                lblBookName.text = data.title
                lblAuthorName.text = data.author
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
