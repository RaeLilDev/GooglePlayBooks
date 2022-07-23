//
//  ViewMoreViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/12/22.
//

import UIKit
import Combine

class ViewMoreViewController: UIViewController {
    
    @IBOutlet weak var collectionviewBooks: UICollectionView!
    
    var selectedList: ListObject?
    
    private var anyCancellable = Set<AnyCancellable>()
    
    private let bookModel: BookModel = BookModelImpl.shared
    
    private var bookList = [BookObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        
        setupCollectionView()
        
        bookModel.getBookByList(listName: selectedList?.listNameEncoded ?? "", id: selectedList?.listID ?? 0).sink { data in
            self.bookList = data
            self.collectionviewBooks.reloadData()
        }.store(in: &anyCancellable)
    }


    private func setupNavbar() {
        self.navigationItem.title = "\(selectedList?.listName ?? "")"
    }
    
    private func setupCollectionView() {
        collectionviewBooks.dataSource = self
        collectionviewBooks.delegate = self
        collectionviewBooks.registerForCell(identifier: BookListCollectionViewCell.identifier)
    }

}

extension ViewMoreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: BookListCollectionViewCell.identifier, indexPath: indexPath) as BookListCollectionViewCell
        cell.delegate = self
        cell.data = bookList[indexPath.row]
        return cell
    }
}

extension ViewMoreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.width-24)/2
        let height: CGFloat = 300
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.navigateToAboutThisBookViewController()
        self.navigateToAboutThisBookViewController(book: bookList[indexPath.row])
    }
}

extension ViewMoreViewController: OnTapBookMoreInfoDelegate {
    func didTapBookMoreInfo(item: BookObject) {
        
    }
    
    
    
    func didTapBookMoreInfo() {
        let vc = ViewMoreBookMoreInfoViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    
    
}

