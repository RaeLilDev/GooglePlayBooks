//
//  ShelfDetailViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/6/22.
//

import UIKit
import Combine

class ShelfDetailViewController: UIViewController {

    @IBOutlet weak var collectionviewBooks: UICollectionView!
    @IBOutlet weak var ivViewAs: UIImageView!
    @IBOutlet weak var ivSortBy: UIImageView!
    @IBOutlet weak var lblSortBy: UILabel!
    @IBOutlet weak var lblShelfName: UILabel!
    @IBOutlet weak var lblBookCount: UILabel!
    
    var viewModel: ShelfDetailViewModel!
    
    private var cancellable = Set<AnyCancellable>()
    
    private var gridViewLayout: ViewAsLayout = .list
    
    private var sortingOrder: SortingOrder = .recentlyOpened {
        didSet {
            switch sortingOrder {
            case .recentlyOpened:
                lblSortBy.text = "Sort By: Recent"
                viewModel.getShelfBooks(by: "date", order: false)
            case .title:
                lblSortBy.text = "Sort By: Title"
                viewModel.getShelfBooks(by: "bookName", order: true)
            case .author:
                lblSortBy.text = "Sort By: Author"
                viewModel.getShelfBooks(by: "authorName", order: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        
        setupCollectionView()
        
        setupGestureRecognizer()
        
        listenShelfDetailViewState()
        
        sortingOrder = .recentlyOpened
        
        viewModel.getShelf()
        
        bindData()
    }

    
    private func listenShelfDetailViewState() {
        viewModel.viewState.sink { state in
            switch state {
            case .successFetchingShelfBooks:
                self.collectionviewBooks.reloadData()
                
            case .shelfUpdate:
                self.bindData()
                
            case .shelfDelete:
                self.navigationController?.popToRootViewController(animated: true)
                
                
            case .failure(let message):
                debugPrint(message)
            }
        }.store(in: &cancellable)
    }
    
    private func bindData() {
        lblShelfName.text = viewModel.getShelfName()
        lblBookCount.text = "\(viewModel.getShelfBookCount()) Books"
    }
    
    private func setupNavbar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_primary"), style: .plain, target: self, action: #selector(onTapMenu))
    }
    
    private func setupCollectionView() {
        collectionviewBooks.dataSource = self
        collectionviewBooks.delegate = self
        collectionviewBooks.registerForCell(identifier: BookListCollectionViewCell.identifier)
        collectionviewBooks.registerForCell(identifier: YourBookListCollectionViewCell.identifier)
    }
    
    private func setupGestureRecognizer() {
        let tapViewAsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapViewAs))
        ivViewAs.isUserInteractionEnabled = true
        ivViewAs.addGestureRecognizer(tapViewAsGestureRecognizer)
        
        let tapSortByGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapSortBy))
        ivSortBy.isUserInteractionEnabled = true
        ivSortBy.addGestureRecognizer(tapSortByGestureRecognizer)
        
    }
    
    
    
    //MARK: - Ontap Callbacks
    @objc private func onTapViewAs() {
        let vc = ViewAsBottomSheetViewController()
        vc.selectedViewAsFormat = gridViewLayout
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    
    @objc private func onTapSortBy() {
        let vc = SortByBottomSheetViewController()
        vc.selectedSortBy = sortingOrder
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    

    @objc private func onTapMenu() {
        let vc = ShelfMoreInfoViewController()
        vc.viewModel = ShelfDetailMoreInfoViewModel(shelf: viewModel.shelf)
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }

}



//MARK: - Tableview Datasource
extension ShelfDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getBookCount()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch gridViewLayout {
        case .list:
            let cell = collectionView.dequeueCell(identifier: YourBookListCollectionViewCell.identifier, indexPath: indexPath) as YourBookListCollectionViewCell
            cell.data = viewModel.getBookByIndex(index: indexPath.row)
            return cell
            
        default:
            let cell = collectionView.dequeueCell(identifier: BookListCollectionViewCell.identifier, indexPath: indexPath) as BookListCollectionViewCell
            cell.data = viewModel.getBookByIndex(index: indexPath.row)
            return cell
        }
    }
    
}

//MARK: - Tableview Delegate
extension ShelfDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch gridViewLayout {
        case .list:
            let width: CGFloat = (collectionView.bounds.width-40)
            let height: CGFloat = 120
            return CGSize(width: width, height: height)
            
        case .smallGrid:
            let width: CGFloat = (collectionView.bounds.width-24)/3
            let height: CGFloat = 230
            return CGSize(width: width, height: height)
            
        case .largeGrid:
            let width: CGFloat = (collectionView.bounds.width-24)/2
            let height: CGFloat = 300
            return CGSize(width: width, height: height)
        }
    }
}


extension ShelfDetailViewController: OnTapViewAsDelegate {
    func didTapViewAsItem(item: ViewAsLayout) {
        gridViewLayout = item
        collectionviewBooks.reloadData()
    }
}


extension ShelfDetailViewController: OnTapSortingOrderDelegate {
    func didTapSortingOrderItem(item: SortingOrder) {
        sortingOrder = item
        collectionviewBooks.reloadData()
    }
    
}

extension ShelfDetailViewController: OnTapShelfMoreInfoDelegate {
    func didTapRenameShelf() {
        self.navigateToCreateShelfViewController(shelf: viewModel.shelf, isRename: true)
    }
    
    func didTapDeleteShelf() {
        self.viewModel.deleteShelf()
    }
    
    
}
