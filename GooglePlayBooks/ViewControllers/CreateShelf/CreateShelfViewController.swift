//
//  CreateShelfViewController.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/6/22.
//

import UIKit
import Combine

class CreateShelfViewController: UIViewController {
    
    @IBOutlet weak var txtFieldShelfName: UITextField!
    @IBOutlet weak var lblTxtCount: UILabel!
    
    private var cancellable = Set<AnyCancellable>()
    
    var viewModel: CreateShelfViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        
        setupTextField()
        
        listenCreateShelfViewState()
    }

    private func setupNavbar() {
        
        if viewModel.isRename {
            self.navigationItem.title = "Rename Shelf"
        } else {
            self.navigationItem.title = "Create Shelf"
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(onTapDone))
    }
    
    private func setupTextField() {
        
        if viewModel.isRename {
            txtFieldShelfName.text = viewModel.getShelfName()
            lblTxtCount.text = "\(viewModel.getShelfName().count)/50``"
        }
        
        txtFieldShelfName.setUpUnderline()
        
        listenShelfNameTxtField()
    }
    
    private func listenShelfNameTxtField() {
        let textFieldPublisher = NotificationCenter.default
            .publisher(for: UISearchTextField.textDidChangeNotification, object: txtFieldShelfName)
                    .map( {
                        ($0.object as? UITextField)?.text
                    })
                
        textFieldPublisher
                    .sink(receiveValue: { value in
                        let name = String(value!.prefix(50))
                        self.txtFieldShelfName.text = name
                        self.checkIsValidShelfName(name: name)
                    })
                    .store(in: &cancellable)
    }
    
    
    private func checkIsValidShelfName(name: String) {
        
        let txtCount = name.count
        lblTxtCount.text = "\(txtCount)/50"
        if txtCount == 50 {
            lblTxtCount.textColor = .red
        } else {
            lblTxtCount.textColor = .gray
        }
        
    }
    
    
    private func listenCreateShelfViewState() {
        viewModel.viewState.sink { state in
            switch state {
            case .addShelfSuccess:
                self.navigationController?.popViewController(animated: true)
                
            case .renameShelfSuccess:
                self.navigationController?.popViewController(animated: true)
                
            case .failure(let message):
                debugPrint(message)
                
            }
        }.store(in: &cancellable)
    }
    
    
    @objc private func onTapDone() {
        
        if viewModel.isRename {
            viewModel.renameShelf(with: txtFieldShelfName.text ?? "")
        } else {
            viewModel.createShelf(with: txtFieldShelfName.text ?? "")
        }
        
    }

    
}


