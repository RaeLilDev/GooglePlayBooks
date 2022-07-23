//
//  YourBookMoreInfoViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/9/22.
//

import UIKit

class YourBookMoreInfoViewController: UIViewController {

    @IBOutlet weak var viewDismiss: UIView!
    @IBOutlet weak var viewAddToWishList: UIStackView!
    @IBOutlet weak var viewAddToShelves: UIStackView!
    @IBOutlet weak var viewAboutThisBook: UIStackView!
    
    var delegate: OnTapYourBookMoreInfoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGestureRecognizer()
    }

    private func setupGestureRecognizer() {
        let tapDismissGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapDismiss))
        viewDismiss.isUserInteractionEnabled = true
        viewDismiss.addGestureRecognizer(tapDismissGestureRecognizer)
        
        let tapAddToShelvesGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapAddToShelves))
        viewAddToShelves.isUserInteractionEnabled = true
        viewAddToShelves.addGestureRecognizer(tapAddToShelvesGestureRecognizer)
        
        
        let tapAboutThisBookGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapAboutThisBook))
        viewAboutThisBook.isUserInteractionEnabled = true
        viewAboutThisBook.addGestureRecognizer(tapAboutThisBookGestureRecognizer)
    }
    
    
    //MARK: - Ontap Callbacks
    @objc private func onTapDismiss() {
        self.dismiss(animated: true)
    }
    
    @objc private func onTapAddToWishlist() {
        
    }
    
    @objc private func onTapAddToShelves() {
        self.dismiss(animated: true)
        delegate?.didTapAddToShelves()
    }
    
    @objc private func onTapAboutThisBook() {
        self.dismiss(animated: true)
        delegate?.didTapAboutThisBook()
    }

}
