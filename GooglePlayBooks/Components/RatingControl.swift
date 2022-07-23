//
//  RatingControl.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/30/22.
//

import UIKit

@IBDesignable
class RatingControl: UIStackView {
    
    @IBInspectable var starSize: CGSize = CGSize(width: 50.0, height: 50.0) {
        didSet {
            setUpButtons()
            updateButtonRating()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setUpButtons()
            updateButtonRating()
        }
    }
    
    @IBInspectable var rating: Int = 3 {
        didSet {
            updateButtonRating()
        }
    }
    
    var ratingButtons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButtons()
        updateButtonRating()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButtons()
        updateButtonRating()
    }
    
    private func setUpButtons() {
        
        clearExistingButton()
        
        for  _ in 0..<starCount {
            let button = UIButton()
            
            //set button image for different state
            button.setImage(UIImage(systemName: "star.fill"), for: .selected)
            button.setImage(UIImage(systemName: "star"), for: .normal)
            
            
            button.translatesAutoresizingMaskIntoConstraints = false
            //set buttons width and height
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //place button in stackview
            addArrangedSubview(button)
            button.isUserInteractionEnabled = false
            
            ratingButtons.append(button)
        }
    }
    
    private func updateButtonRating() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    private func clearExistingButton() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
    }
    
}

