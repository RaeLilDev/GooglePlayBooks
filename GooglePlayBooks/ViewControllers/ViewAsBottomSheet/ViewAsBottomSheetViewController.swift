//
//  ViewAsBottomSheetViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/3/22.
//

import UIKit

class ViewAsBottomSheetViewController: UIViewController {

    @IBOutlet weak var tableviewViewAs: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewDismiss: UIView!
    
    var selectedViewAsFormat: ViewAsLayout = .list
    var delegate: OnTapViewAsDelegate?
    
    private var viewAsList: [String] = ["List", "Large grid", "Small grid"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableview()
        
        setupGestureRecognizer()
    }
    
    
    private func setupTableview() {
        tableviewViewAs.dataSource = self
        tableviewViewAs.delegate = self
        tableviewViewAs.registerForCell(identifier: RadioItemTableViewCell.identifier)
    }
    
    private func setupGestureRecognizer() {
        let tapViewDismissGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapViewDismiss))
        viewDismiss.isUserInteractionEnabled = true
        viewDismiss.addGestureRecognizer(tapViewDismissGestureRecognizer)
    }
    
    override func viewDidLayoutSubviews(){
        tableviewViewAs.frame = CGRect(x: tableviewViewAs.frame.origin.x, y: tableviewViewAs.frame.origin.y, width: tableviewViewAs.frame.size.width, height: tableviewViewAs.contentSize.height)
       tableviewViewAs.reloadData()
   }
    
    @objc private func onTapViewDismiss() {
        self.dismiss(animated: true)
    }
}

extension ViewAsBottomSheetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewAsList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(identifier: RadioItemTableViewCell.identifier, indexPath: indexPath) as RadioItemTableViewCell
        cell.name = viewAsList[indexPath.row]
        tableviewHeight.constant = tableView.contentSize.height
        if indexPath.row == selectedViewAsFormat.rawValue {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        return cell
    }
    
}


extension ViewAsBottomSheetViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapViewAsItem(item: ViewAsLayout.init(rawValue: indexPath.row) ?? .list)
        self.dismiss(animated: true)
    }
}
