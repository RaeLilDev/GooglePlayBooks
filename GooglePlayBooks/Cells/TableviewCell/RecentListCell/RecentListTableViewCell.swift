//
//  RecentListTableViewCell.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/28/22.
//

import UIKit

class RecentListTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewRecentOpen: UICollectionView!
    
    var bookList = [BookObject]()
    
    var data: [BookObject]? {
        didSet {
            if let data = data {
                bookList = data
                collectionViewRecentOpen.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
    }
    
    
    private func setupCollectionView() {
        collectionViewRecentOpen.dataSource = self
        collectionViewRecentOpen.registerForCell(identifier: RecentOpenCollectionViewCell.identifier)
    }
    
}


extension RecentListTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: RecentOpenCollectionViewCell.identifier, indexPath: indexPath) as RecentOpenCollectionViewCell
        cell.data = bookList[indexPath.row]
        return cell
    }
    
    
}

