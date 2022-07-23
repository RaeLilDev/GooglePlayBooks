//
//  BookDetailViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/30/22.
//

import UIKit
import Combine


class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var tableviewBookDetail: UITableView!
    
    var viewModel: BookDetailViewModel!
    
    private var anyCancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableview()
        
        listenBookDetailViewState()
       
    }
    
    private func setupTableview() {
        tableviewBookDetail.dataSource = self
        tableviewBookDetail.registerForCell(identifier: CommentTableViewCell.identifier)
        tableviewBookDetail.registerForCell(identifier: BookInfoTableViewCell.identifier)
        tableviewBookDetail.registerForCell(identifier: BookActionItemTableViewCell.identifier)
        tableviewBookDetail.registerForCell(identifier: AboutBookTableViewCell.identifier)
        tableviewBookDetail.registerForCell(identifier: RatingAndReviewTableViewCell.identifier)
    }
    
    
    private func listenBookDetailViewState() {
        viewModel.viewState.sink { state in
            switch state {
                
            case .addToWishList:
                self.tableviewBookDetail.reloadSections(IndexSet(integer: 1), with: .automatic)
                
            case .deleteFromLibrary:
                self.tableviewBookDetail.reloadSections(IndexSet(integer: 1), with: .automatic)
                
            case .failure(let message):
                debugPrint(message)
            }
        }.store(in: &anyCancellable)
    }


}

extension BookDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCountBySection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemType = viewModel.getItemTypeByIndex(index: indexPath.section)
        switch itemType {
            
        case .CommentList(_):
            let cell = tableView.dequeueCell(identifier: CommentTableViewCell.identifier, indexPath: indexPath) as CommentTableViewCell
            return cell
            
        case .BookInfoSection:
            let cell = tableView.dequeueCell(identifier: BookInfoTableViewCell.identifier, indexPath: indexPath) as BookInfoTableViewCell
            cell.data = viewModel.getBook()
            return cell
            
        case .BookActionSection:
            let cell = tableView.dequeueCell(identifier: BookActionItemTableViewCell.identifier, indexPath: indexPath) as BookActionItemTableViewCell
            cell.delegate = self
            cell.isInWishList = viewModel.isBookInWishList()
            return cell
            
        case .AboutBookSection:
            let cell = tableView.dequeueCell(identifier: AboutBookTableViewCell.identifier, indexPath: indexPath) as AboutBookTableViewCell
            cell.lblAbout.text = viewModel.getBookDescription()
            return cell
            
            
        case .RatingAndReviewsSection:
            let cell = tableView.dequeueCell(identifier: RatingAndReviewTableViewCell.identifier, indexPath: indexPath) as RatingAndReviewTableViewCell
            return cell
        }
    }
    
    
}

extension BookDetailViewController: OnTapBookActionItemDelegate {
    func didTapAddToWishList() {
        viewModel.addToWishList()
    }
    
    func didTapDeleteFromLibrary() {
        viewModel.deleteFromWishList()
    }
    
    
}
