//
//  AddToShelvesViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/9/22.
//

import UIKit
import Combine

class AddToShelvesViewController: UIViewController {

    @IBOutlet weak var tableviewShelves: UITableView!
    @IBOutlet weak var viewNoShelves: UIView!
    
    var viewModel: AddToShelvesViewModel!
    
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        
        setupTableview()
        
        viewModel.fetchAllSheves()
        
        listenShelfViewState()
    }
    
    private func setupNavbar() {
        self.navigationItem.title = "Add To Shelves"
    }
    
    private func setupTableview() {
        tableviewShelves.dataSource = self
        tableviewShelves.delegate = self
        tableviewShelves.registerForCell(identifier: AddToShelfTableViewCell.identifier)
    }
    
    
    private func listenShelfViewState() {
        viewModel.viewState.sink { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .fetchShelvesSuccess:
                self.viewNoShelves.isHidden = true
                self.tableviewShelves.isHidden = false
                self.tableviewShelves.reloadData()
                
            case .noShelveExist:
                self.viewNoShelves.isHidden = false
                self.tableviewShelves.isHidden = true
                
            case .addToShelfSuccess:
                debugPrint("Success to add book to shelf")
                self.navigationController?.popViewController(animated: true)
                
            case .addToShelfFail:
                debugPrint("Fail to add book to shelf")
                
            case .failure(let message):
                debugPrint(message)
            }
        }.store(in: &cancellable)
    }
    
    
    @IBAction func onTapCreateNewShelf(_ sender: UIButton) {
        self.navigateToCreateShelfViewController(isRename: false)
    }
    

}

extension AddToShelvesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getShelvesCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(identifier: AddToShelfTableViewCell.identifier, indexPath: indexPath) as AddToShelfTableViewCell
        cell.data = viewModel.getShelfByIndex(index: indexPath.row)
        return cell
    }
    
    
}

extension AddToShelvesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.addBookToShelf(by: indexPath.row)
    }
}
