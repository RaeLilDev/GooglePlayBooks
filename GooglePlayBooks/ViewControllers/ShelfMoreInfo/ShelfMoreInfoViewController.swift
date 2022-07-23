//
//  ShelfMoreInfoViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/10/22.
//

import UIKit

class ShelfMoreInfoViewController: UIViewController {

    @IBOutlet weak var viewDismiss: UIView!
    @IBOutlet weak var lblShelfName: UILabel!
    @IBOutlet weak var viewRenameShelf: UIStackView!
    @IBOutlet weak var viewDeleteShelf: UIStackView!
    
    var viewModel: ShelfDetailMoreInfoViewModel!
    
    var delegate: OnTapShelfMoreInfoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGestureRecognizer()
    
        bindData()
        
    }
    
    
    private func bindData() {
        lblShelfName.text = viewModel.getShelfName()
    }
    
    
    
    private func setupGestureRecognizer() {
        let tapDismissGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapDismiss))
        viewDismiss.isUserInteractionEnabled = true
        viewDismiss.addGestureRecognizer(tapDismissGestureRecognizer)
        
        
        let tapRenameShelfGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapRenameShelf))
        viewRenameShelf.isUserInteractionEnabled = true
        viewRenameShelf.addGestureRecognizer(tapRenameShelfGestureRecognizer)
        
        let tapDeleteShelfGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapDeleteShelf))
        viewDeleteShelf.isUserInteractionEnabled = true
        viewDeleteShelf.addGestureRecognizer(tapDeleteShelfGestureRecognizer)
    }
    
    
    @objc private func onTapDismiss() {
        self.dismiss(animated: true)
    }
    
    @objc private func onTapRenameShelf() {
        delegate?.didTapRenameShelf()
        self.dismiss(animated: true)
    }
    
    @objc private func onTapDeleteShelf() {
        delegate?.didTapDeleteShelf()
        self.dismiss(animated: true)
    }


}
