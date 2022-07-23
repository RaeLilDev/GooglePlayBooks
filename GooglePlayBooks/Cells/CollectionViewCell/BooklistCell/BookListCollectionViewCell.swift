//
//  BookListCollectionViewCell.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/28/22.
//

import UIKit
import SDWebImage

class BookListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    
    var delegate: OnTapBookMoreInfoDelegate?
    
    var data: BookObject? {
        didSet {
            if let data = data {
                lblBookName.text = data.title.capitalized
                lblAuthorName.text = data.author
                ivCover.sd_setImage(with: URL(string: data.bookImage))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
        viewShadow.translatesAutoresizingMaskIntoConstraints = false
        viewShadow.backgroundColor = .white
        viewShadow.layer.cornerRadius = 8
        viewShadow.layer.masksToBounds = false
        viewShadow.layer.shadowOpacity = 0.2
        viewShadow.layer.shadowOffset = CGSize(width: 2, height: 4.0)
        viewShadow.layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
        viewShadow.layer.shadowRadius = 6.0
    }
    
    @IBAction func onTapBtnMoreInfo(_ sender: UIButton) {
        delegate?.didTapBookMoreInfo(item: data ?? BookObject())
    }
    

}
