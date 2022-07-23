//
//  HomeViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/27/22.
//

import UIKit
import Combine



class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableviewHome: UITableView!
    
    private let searchBarView = CustomSearchBar()
    
    private var anyCancellable = Set<AnyCancellable>()
    
    private var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeViewModel()
        
        setupTableview()
        
        viewModel.getAllBooks()
        
        listenViewState()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavbar()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBarView.removeFromSuperview()
    }
    
    private func setupNavbar() {
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.addSubview(searchBarView)
        searchBarView.delegate = self
        
        NSLayoutConstraint.activate([
            searchBarView.leftAnchor.constraint(equalTo: navigationBar.leftAnchor),
            searchBarView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor),
            searchBarView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            searchBarView.topAnchor.constraint(equalTo: navigationBar.topAnchor),
        ])
    }
    
    
    private func setupTableview() {
        tableviewHome.dataSource = self
        tableviewHome.registerForCell(identifier: BookListTableViewCell.identifier)
        tableviewHome.registerForCell(identifier: CategorySelectionTableViewCell.identifier)
        tableviewHome.registerForCell(identifier: RecentListTableViewCell.identifier)
    }
    
    private func listenViewState() {
        viewModel.viewState.sink { state in
            switch state {
            case .success:
                self.tableviewHome.reloadData()
                
            case .failure:
                debugPrint("Failed!")
            }
        }.store(in: &anyCancellable)
    }
    
}


//MARK: - Tableveiw Datasource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemType = viewModel.getItems(indexPath.section)
        switch itemType {
        case .ItemList(let items):
            let cell = tableView.dequeueCell(identifier: BookListTableViewCell.identifier, indexPath: indexPath) as BookListTableViewCell
            cell.data = items[indexPath.row]
            cell.delegate = self
            return cell
            
        case .CategorySelection:
            let cell = tableView.dequeueCell(identifier: CategorySelectionTableViewCell.identifier, indexPath: indexPath) as CategorySelectionTableViewCell
            return cell
            
        case .RecentlyOpenedItems(let items):
            let cell = tableView.dequeueCell(identifier: RecentListTableViewCell.identifier, indexPath: indexPath) as RecentListTableViewCell
            cell.data = items
            return cell
                    
        }
    }
}


extension HomeViewController: OnTapSearchBarDelegate {
    func didTapSearchBar() {
        self.navigateToSearchViewController()
    }
}

extension HomeViewController: OnTapHomeBookItemDelegate {
    
    func didTapBookItem(item: BookObject) {
        self.navigateToAboutThisBookViewController(book: item)
    }
    
    func didTapBookMoreInfo(item: BookObject) {
        let vc = BookMoreInfoViewController()
        vc.delegate = self
        vc.viewModel = BookMoreInfoViewModel(book: item)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    
    func didTapViewMore(item: ListObject) {
        self.navigateToViewMoreViewController(listItem: item)
    }
    
    func didTapAddToShelves(item: BookObject) {
        self.navigateToAddToShelvesViewController(book: item)
    }
    
}
