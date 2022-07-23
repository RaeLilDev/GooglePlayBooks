//
//  BookInfoTableViewCell.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/30/22.
//

import UIKit

class BookInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var ivBook: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthoerName: UILabel!
    @IBOutlet weak var lblWeekList: UILabel!
    
    var data: BookObject? {
        didSet {
            if let data = data {
                ivBook.sd_setImage(with: URL(string: data.bookImage))
                lblTitle.text = data.title
                lblAuthoerName.text = data.author
                lblWeekList.text = "Week List: \(data.weekOnList)"
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
