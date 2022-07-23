//
//  SortByBottomSheetViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/5/22.
//

import UIKit

class SortByBottomSheetViewController: UIViewController {

    @IBOutlet weak var tableviewSortBy: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewDismiss: UIView!
    
    var selectedSortBy: SortingOrder = .title
    var delegate: OnTapSortingOrderDelegate?
    
    private var sortByList: [String] = ["Recently Opened", "Title", "Author"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupTableview()
        
        setupGestureRecognizer()
    }
    
    private func setupTableview() {
        tableviewSortBy.dataSource = self
        tableviewSortBy.delegate = self
        tableviewSortBy.registerForCell(identifier: RadioItemTableViewCell.identifier)
    }
    
    private func setupGestureRecognizer() {
        let tapViewDismissGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapViewDismiss))
        viewDismiss.isUserInteractionEnabled = true
        viewDismiss.addGestureRecognizer(tapViewDismissGestureRecognizer)
    }
    
    override func viewDidLayoutSubviews(){
        tableviewSortBy.frame = CGRect(x: tableviewSortBy.frame.origin.x, y: tableviewSortBy.frame.origin.y, width: tableviewSortBy.frame.size.width, height: tableviewSortBy.contentSize.height)
       tableviewSortBy.reloadData()
   }
    
    @objc private func onTapViewDismiss() {
        self.dismiss(animated: true)
    }
    

}

extension SortByBottomSheetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortByList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(identifier: RadioItemTableViewCell.identifier, indexPath: indexPath) as RadioItemTableViewCell
        cell.name = sortByList[indexPath.row]
        tableviewHeight.constant = tableView.contentSize.height
        if indexPath.row == selectedSortBy.rawValue {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        return cell
    }
}

extension SortByBottomSheetViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapSortingOrderItem(item: SortingOrder.init(rawValue: indexPath.row) ?? .title)
        self.dismiss(animated: true)
    }
    
}
