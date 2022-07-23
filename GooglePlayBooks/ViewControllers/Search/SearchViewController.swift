//
//  SearchViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/10/22.
//

import UIKit
import Combine

class SearchViewController: UIViewController {

    @IBOutlet weak var tableviewSearchResult: UITableView!
    
    private let searchBar = UISearchBar()
    
    private var viewModel: SearchViewModel!
    
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SearchViewModel()
        
        setupSearchBar()
        
        setupTableview()
        
        listenSearchBarTextChanges()
        
        listenSearchViewState()
    }
    
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search..."
        
        navigationItem.titleView = searchBar
    }
    
    private func listenSearchBarTextChanges() {
        let textFieldPublisher = NotificationCenter.default
            .publisher(for: UISearchTextField.textDidChangeNotification, object: searchBar.searchTextField)
                    .map( {
                        ($0.object as? UISearchTextField)?.text
                    })
                
        textFieldPublisher
                    .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
                    .sink(receiveValue: { value in
                        self.viewModel.searchBooksByName(query: value ?? "")
                    })
                    .store(in: &cancellable)
    }
    
    private func listenSearchViewState() {
        viewModel.viewState.sink { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .success:
                self.tableviewSearchResult.reloadData()
                
            case .failure:
                debugPrint("Something Search went wrong!")
            }
        }.store(in: &cancellable)

    }
    
    private func setupTableview() {
        tableviewSearchResult.dataSource = self
        tableviewSearchResult.delegate = self
        tableviewSearchResult.registerForCell(identifier: SearchResultTableViewCell.identifier)
    }

}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getBookCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(identifier: SearchResultTableViewCell.identifier, indexPath: indexPath) as SearchResultTableViewCell
        cell.data = viewModel.getBookByIndex(indexPath.row)
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToAboutThisBookViewController(book: viewModel.getBookByIndex(indexPath.row))
    }
}
