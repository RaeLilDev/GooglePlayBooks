//
//  LibraryViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/4/22.
//

import UIKit
import Combine

class LibraryViewController: UIViewController {

    @IBOutlet weak var collectionviewLibrary: UICollectionView!
    @IBOutlet weak var ivViewAs: UIImageView!
    @IBOutlet weak var ivSortBy: UIImageView!
    @IBOutlet weak var lblSortBy: UILabel!
    @IBOutlet weak var viewYourBooks: UIView!
    @IBOutlet weak var lblYourBooks: UILabel!
    @IBOutlet weak var overlayYourBooks: UIView!
    @IBOutlet weak var viewYourShelves: UIView!
    @IBOutlet weak var lblYourShelves: UILabel!
    @IBOutlet weak var overlayYourShelves: UIView!
    @IBOutlet weak var containerYourShelves: UIView!
    @IBOutlet weak var containerSelection: UIStackView!
    @IBOutlet weak var btnCreateNew: UIButton!
    
    private var viewModel: LibraryViewModel!
    private var cancellable = Set<AnyCancellable>()
    
    var gridViewLayout: ViewAsLayout = .list
    
    var sortingOrder: SortingOrder = .recentlyOpened {
        didSet {
            switch sortingOrder {
            case .recentlyOpened:
                lblSortBy.text = "Sort By: Recent"
                viewModel.fetchWishList(by: "date", order: false)
            case .title:
                lblSortBy.text = "Sort By: Title"
                viewModel.fetchWishList(by: "bookName", order: true)
            case .author:
                lblSortBy.text = "Sort By: Author"
                viewModel.fetchWishList(by: "authorName", order: true)
            }
        }
    }
    
    
    var isYourBooksSelected: Bool = true {
        didSet {
            if isYourBooksSelected {
                containerSelection.isHidden = false
                collectionviewLibrary.isHidden = false
                lblYourBooks.textColor = UIColor(named: "colorPrimary")
                overlayYourBooks.backgroundColor = UIColor(named: "colorPrimary")
                lblYourShelves.textColor = .darkGray
                overlayYourShelves.backgroundColor = .clear
                btnCreateNew.isHidden = true
                collectionviewLibrary.reloadData()
            } else {
                containerSelection.isHidden = true
                lblYourShelves.textColor = UIColor(named: "colorPrimary")
                overlayYourShelves.backgroundColor = UIColor(named: "colorPrimary")
                lblYourBooks.textColor = .darkGray
                overlayYourBooks.backgroundColor = .clear
                btnCreateNew.isHidden = false
                collectionviewLibrary.reloadData()
            }
        }
    }
    
    private let searchBarView = CustomSearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = LibraryViewModel()
        
        containerYourShelves.isHidden = true
        
        isYourBooksSelected = true
        
        setupOverlayView()
        
        setupCollectionView()
        
        setupGestureRecognizer()
        
        viewModel.fetchWishList(by: "date", order: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavbar()
        
        viewModel.fetchAllSheves()
        
        listenLibraryViewModelState()
    }
    
    private func listenLibraryViewModelState() {
        viewModel.viewState.sink { state in
            switch state {
            case .wishList:
                self.collectionviewLibrary.reloadData()
                
            case .fetchShelvesSuccess:
                debugPrint("Shelf success")
                if !self.isYourBooksSelected {
                    self.containerYourShelves.isHidden = true
                }
                self.collectionviewLibrary.reloadData()
                
            case .noShelveExist:
                debugPrint("No Shelf found")
                if !self.isYourBooksSelected {
                    self.containerYourShelves.isHidden = false
                }
                self.collectionviewLibrary.reloadData()
                
            case .failure(let message):
                debugPrint(message)
            }
        }.store(in: &cancellable)
    }
    
    private func setupNavbar() {
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.addSubview(searchBarView)
        
        NSLayoutConstraint.activate([
            searchBarView.leftAnchor.constraint(equalTo: navigationBar.leftAnchor),
            searchBarView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor),
            searchBarView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            searchBarView.topAnchor.constraint(equalTo: navigationBar.topAnchor),
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBarView.removeFromSuperview()
    }
    
    
    private func setupOverlayView() {
        overlayYourBooks.layer.cornerRadius = 4
        overlayYourBooks.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        overlayYourShelves.layer.cornerRadius = 4
        overlayYourShelves.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    private func setupCollectionView() {
        collectionviewLibrary.dataSource = self
        collectionviewLibrary.delegate = self
        collectionviewLibrary.registerForCell(identifier: BookListCollectionViewCell.identifier)
        collectionviewLibrary.registerForCell(identifier: YourBookListCollectionViewCell.identifier)
        collectionviewLibrary.registerForCell(identifier: YourShelvesCollectionViewCell.identifier)
    }
    
    private func setupGestureRecognizer() {
        let tapViewAsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapViewAs))
        ivViewAs.isUserInteractionEnabled = true
        ivViewAs.addGestureRecognizer(tapViewAsGestureRecognizer)
        
        let tapSortByGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapSortBy))
        ivSortBy.isUserInteractionEnabled = true
        ivSortBy.addGestureRecognizer(tapSortByGestureRecognizer)
        
        let tapYourBooksGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapYourBooks))
        viewYourBooks.isUserInteractionEnabled = true
        viewYourBooks.addGestureRecognizer(tapYourBooksGestureRecognizer)
        
        
        let tapYourShelvesGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapYourShelves))
        viewYourShelves.isUserInteractionEnabled = true
        viewYourShelves.addGestureRecognizer(tapYourShelvesGestureRecognizer)
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
    
    
    @objc private func onTapYourBooks() {
        isYourBooksSelected = true
    }
    
    
    @objc private func onTapYourShelves() {
        isYourBooksSelected = false
    }
    
    
    
    
    @IBAction func onTapCreateNewShelve(_ sender: UIButton) {
        self.navigateToCreateShelfViewController(isRename: false)
    }
    
    
}

//MARK: - Tableview Datasource
extension LibraryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isYourBooksSelected {
            return viewModel.getBookListCount()
        } else {
            return viewModel.getShelvesCount()
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isYourBooksSelected {
            switch gridViewLayout {
            case .list:
                let cell = collectionView.dequeueCell(identifier: YourBookListCollectionViewCell.identifier, indexPath: indexPath) as YourBookListCollectionViewCell
                cell.data = viewModel.getBookByIndex(index: indexPath.row)
                cell.delegate = self
                return cell
                
            default:
                let cell = collectionView.dequeueCell(identifier: BookListCollectionViewCell.identifier, indexPath: indexPath) as BookListCollectionViewCell
                cell.data = viewModel.getBookByIndex(index: indexPath.row)
                cell.delegate = self
                return cell
            }
        } else {
            let cell = collectionView.dequeueCell(identifier: YourShelvesCollectionViewCell.identifier, indexPath: indexPath) as YourShelvesCollectionViewCell
            cell.data = viewModel.getShelfByIndex(index: indexPath.row)
            return cell
        }
        
        
    }
}

//MARK: - Tableview Delegate
extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isYourBooksSelected {
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
        } else {
            let width: CGFloat = (collectionView.bounds.width-40)
            let height: CGFloat = 100
            return CGSize(width: width, height: height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isYourBooksSelected {
            self.navigateToAboutThisBookViewController(book: viewModel.getBookByIndex(index: indexPath.row))
        } else {
            self.navigateToShelfDetailViewController(shelf: viewModel.getShelfByIndex(index: indexPath.row))
        }
    }
}

extension LibraryViewController: OnTapViewAsDelegate {
    func didTapViewAsItem(item: ViewAsLayout) {
        gridViewLayout = item
        collectionviewLibrary.reloadData()
    }
}

extension LibraryViewController: OnTapSortingOrderDelegate {
    func didTapSortingOrderItem(item: SortingOrder) {
        sortingOrder = item
        collectionviewLibrary.reloadData()
    }
}

extension LibraryViewController: OnTapBookMoreInfoDelegate {
    func didTapBookMoreInfo(item: BookObject) {
        let vc = BookMoreInfoViewController()
        vc.delegate = self
        vc.viewModel = BookMoreInfoViewModel(book: item)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
}

extension LibraryViewController: OnTapHomeBookItemDelegate {
    func didTapAddToShelves(item: BookObject) {
        self.navigateToAddToShelvesViewController(book: item)
    }
    
    func didTapBookItem(item: BookObject) {
        self.navigateToAboutThisBookViewController(book: item)
    }
    
    func didTapViewMore(item: ListObject) {
        //
    }
    
}
