//
//  BookListTableViewCell.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/28/22.
//

import UIKit


class BookListTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewBookList: UICollectionView!
    @IBOutlet weak var lblBookListTitle: UILabel!
    @IBOutlet weak var ivViewMore: UIImageView!
    
    var delegate: OnTapHomeBookItemDelegate?
    
    var bookList = [BookObject]()
    
    var list: ListObject?
    
    var data: ListObject? {
        didSet {
            if let data = data {
                list = data
                lblBookListTitle.text = data.listName
                bookList = Array(data.books.map { $0 }.prefix(upTo: 5))
                collectionViewBookList.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCollectionview()
        
        setupGestureRecognizer()
    }
    
    
    private func setupCollectionview() {
        collectionViewBookList.dataSource = self
        collectionViewBookList.delegate = self
        collectionViewBookList.registerForCell(identifier: BookListCollectionViewCell.identifier)
    }
    
    
    private func setupGestureRecognizer() {
        let tapViewMoreGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapViewMore))
        ivViewMore.isUserInteractionEnabled = true
        ivViewMore.addGestureRecognizer(tapViewMoreGestureRecognizer)
    }
    
    @objc private func onTapViewMore() {
        delegate?.didTapViewMore(item: list ?? ListObject())
    }
}


//MARK: - Collectionview Datasource
extension BookListTableViewCell: UICollectionViewDataSource {
    
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


extension BookListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 136
        let height: CGFloat = 224
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = bookList[indexPath.row]
        delegate?.didTapBookItem(item: book)
    }
}

extension BookListTableViewCell: OnTapBookMoreInfoDelegate{
    
    func didTapBookMoreInfo(item: BookObject) {
        delegate?.didTapBookMoreInfo(item: item)
    }
}
