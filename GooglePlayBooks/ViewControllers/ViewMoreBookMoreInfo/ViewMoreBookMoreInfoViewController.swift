//
//  ViewMoreBookMoreInfoViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/12/22.
//

import UIKit

class ViewMoreBookMoreInfoViewController: UIViewController {

    @IBOutlet weak var viewDismiss: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGestureRecognizer()
    }

    private func setupGestureRecognizer() {
        let tapDismissGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapDismiss))
        viewDismiss.isUserInteractionEnabled = true
        viewDismiss.addGestureRecognizer(tapDismissGestureRecognizer)
        
    }
    
    
    //MARK: - Ontap Callbacks
    @objc private func onTapDismiss() {
        self.dismiss(animated: true)
    }

    

}
