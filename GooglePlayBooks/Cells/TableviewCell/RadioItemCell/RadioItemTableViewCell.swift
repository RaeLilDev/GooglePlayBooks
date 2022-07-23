//
//  RadioItemTableViewCell.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/3/22.
//

import UIKit

class RadioItemTableViewCell: UITableViewCell {

    @IBOutlet weak var btnRadio: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    var name: String? {
        didSet {
            if let name = name {
                lblName.text = name
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
            
            btnRadio.isSelected = true
            
        } else {
            
            btnRadio.isSelected = false
            
        }
        
    }
    
    
}
