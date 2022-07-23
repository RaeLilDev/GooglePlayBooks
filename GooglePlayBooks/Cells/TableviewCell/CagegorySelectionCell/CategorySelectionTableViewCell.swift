//
//  CategorySelectionTableViewCell.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/28/22.
//

import UIKit

class CategorySelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var viewHighlightEbook: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        viewHighlightEbook.layer.cornerRadius = 4
        viewHighlightEbook.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    
    
}
