//
//  BookMoreInfoViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/30/22.
//

import UIKit
import Combine

class BookMoreInfoViewController: UIViewController {

    
    @IBOutlet weak var viewDismiss: UIView!
    @IBOutlet weak var viewDeleteFromLibrary: UIStackView!
    @IBOutlet weak var viewAddToWishList: UIStackView!
    @IBOutlet weak var viewAddToShelves: UIStackView!
    @IBOutlet weak var viewAboutThisBook: UIStackView!
    @IBOutlet weak var ivBookImage: UIImageView!
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    
    var viewModel: BookMoreInfoViewModel!
    
    var delegate: OnTapHomeBookItemDelegate?
    
    private var anyCancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestureRecognizer()
        
        bindBookData()
        
        initView()
        
        listenBookMoreInfoViewState()
        
    }
    
    private func bindBookData() {
        let book = viewModel.getBook()
        ivBookImage.sd_setImage(with: URL(string: book.bookImage))
        lblBookName.text = book.title
        lblAuthorName.text = book.author
    }
    
    private func initView() {
        if viewModel.isBookInWishList() {
            updateUIToInWishList()
        } else {
            updateUIToNotInWishList()
        }
    }
    
    
    private func listenBookMoreInfoViewState() {
        viewModel.viewState.sink { state in
            switch state {
                
            case .addToWishList:
                self.updateUIToInWishList()
                
            case .deleteFromLibrary:
                self.updateUIToNotInWishList()
                
            case .addToShelves:
                debugPrint("Add To Wishlist")
                
            case .failure(let message):
                debugPrint(message)
            }
        }.store(in: &anyCancellable)
    }

    private func setupGestureRecognizer() {
        let tapViewDismissGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapViewDismiss))
        viewDismiss.isUserInteractionEnabled = true
        viewDismiss.addGestureRecognizer(tapViewDismissGestureRecognizer)
        
        let tapViewDeleteFromLibraryGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapViewDeleteFromLibrary))
        viewDeleteFromLibrary.isUserInteractionEnabled = true
        viewDeleteFromLibrary.addGestureRecognizer(tapViewDeleteFromLibraryGestureRecognizer)
        
        let tapViewAddToWishListGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapAddToWishlist))
        viewAddToWishList.isUserInteractionEnabled = true
        viewAddToWishList.addGestureRecognizer(tapViewAddToWishListGestureRecognizer)
        
        let tapViewAddToShelvesGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapAddToShelves))
        viewAddToShelves.isUserInteractionEnabled = true
        viewAddToShelves.addGestureRecognizer(tapViewAddToShelvesGestureRecognizer)
        
        
        let tapViewAboutThisBookGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapAboutThisBook))
        viewAboutThisBook.isUserInteractionEnabled = true
        viewAboutThisBook.addGestureRecognizer(tapViewAboutThisBookGestureRecognizer)
    }
    
    @objc private func onTapViewDismiss() {
        self.dismiss(animated: true)
    }
    
    @objc private func onTapViewDeleteFromLibrary() {
        viewModel.deleteFromWishList()
    }
    
    @objc private func onTapAddToWishlist() {
        viewModel.addToWishList()
    }
    
    @objc private func onTapAddToShelves() {
        delegate?.didTapAddToShelves(item: viewModel.getBook())
        self.dismiss(animated: true)
    }
    
    @objc private func onTapAboutThisBook() {
        
        delegate?.didTapBookItem(item: viewModel.getBook())
        self.dismiss(animated: true)
    }

    private func updateUIToInWishList() {
        viewDeleteFromLibrary.isHidden = false
        viewAddToWishList.isHidden = true
    }
    
    
    private func updateUIToNotInWishList() {
        viewDeleteFromLibrary.isHidden = true
        viewAddToWishList.isHidden = false
    }

}
