//
//  RecentOpenCollectionViewCell.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/28/22.
//

import UIKit

class RecentOpenCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var ivCover: UIImageView!
    
    
    var data: BookObject? {
        didSet {
            if let data = data {
                ivCover.sd_setImage(with: URL(string: data.bookImage))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }
    
    private func setupView() {
        setupShadowView()
        
        setupCoverImage()
    }
    
    private func setupCoverImage() {
        ivCover.layer.cornerRadius = 8
        
    }
    
    private func setupShadowView() {
        viewShadow.backgroundColor = .white
        viewShadow.layer.cornerRadius = 8
        viewShadow.layer.masksToBounds = false
        viewShadow.layer.shadowOpacity = 0.2
        viewShadow.layer.shadowOffset = CGSize(width: 1, height: 2.0)
        viewShadow.layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
        viewShadow.layer.shadowRadius = 6.0
    }

}
