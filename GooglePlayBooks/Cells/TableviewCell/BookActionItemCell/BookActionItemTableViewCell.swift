//
//  BookActionItemTableViewCell.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/30/22.
//

import UIKit

class BookActionItemTableViewCell: UITableViewCell {

    @IBOutlet weak var btnFreeSample: UIButton!
    @IBOutlet weak var btnAddToWishList: UIButton!
    @IBOutlet weak var deleteFromLibrary: UIButton!
    
    var delegate: OnTapBookActionItemDelegate?
    
    var isInWishList: Bool? {
        didSet {
            if let isInWishList = isInWishList {
                deleteFromLibrary.isHidden = !isInWishList
                btnAddToWishList.isHidden = isInWishList
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupBtnFreeSample()
    }
    
    
    private func setupBtnFreeSample() {
        btnFreeSample.backgroundColor = .clear
        btnFreeSample.layer.cornerRadius = 8
        btnFreeSample.layer.borderWidth = 0.25
        btnFreeSample.layer.borderColor = UIColor(named: "colorPrimary")?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func onTapAddToWishList(_ sender: UIButton) {
        delegate?.didTapAddToWishList()
    }
    
    
    @IBAction func onTapDeleteFromLibrary(_ sender: UIButton) {
        delegate?.didTapDeleteFromLibrary()
    }
    
    
    
}
