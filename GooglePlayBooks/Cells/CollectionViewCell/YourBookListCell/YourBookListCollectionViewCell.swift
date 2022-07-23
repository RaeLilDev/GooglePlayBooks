//
//  YourBookListCollectionViewCell.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/4/22.
//

import UIKit

class YourBookListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivMoreInfo: UIImageView!
    @IBOutlet weak var ivBookImage: UIImageView!
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    var delegate: OnTapBookMoreInfoDelegate?
    
    var data: BookObject? {
        didSet {
            if let data = data {
                ivBookImage.sd_setImage(with: URL(string: data.bookImage))
                lblBookName.text = data.title
                lblAuthor.text = data.author
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupGestureRecognizer()
        
    }
    
    private func setupGestureRecognizer() {
        let tapMoreInfoGesture = UITapGestureRecognizer(target: self, action: #selector(onTapMoreInfo))
        ivMoreInfo.isUserInteractionEnabled = true
        ivMoreInfo.addGestureRecognizer(tapMoreInfoGesture)
    }
    
    @objc private func onTapMoreInfo() {
        delegate?.didTapBookMoreInfo(item: data ?? BookObject())
    }
    
}
