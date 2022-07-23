//
//  CustomSearchBar.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 6/27/22.
//

import UIKit

class CustomSearchBar: UIView, UISearchBarDelegate {
    
    var delegate: OnTapSearchBarDelegate?

    lazy private var viewSearchContainer: UIStackView = {
        let ui = UIStackView()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.axis = .horizontal
        ui.alignment = .center
        ui.spacing = 16
        return ui
    }()
    
    lazy private var searchBar: UISearchBar = {
        let ui = UISearchBar()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.placeholder = "Search Play Books"
        return ui
    }()
    
    lazy private var imageContainer: UIView = {
        let ui = UIView()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.backgroundColor = UIColor(named: "colorPrimary")
        ui.layer.cornerRadius = 20
        return ui
    }()
    
    lazy private var imageProfile: UIImageView = {
        let ui = UIImageView()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.layer.cornerRadius = 20
        ui.image = UIImage(named: "profile")
        ui.contentMode = .scaleAspectFill
        ui.layer.masksToBounds = true
        return ui
    }()
    
    //MARK: - Override Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildView()
    }
    
    
    private func buildView() {
        
        self.addSubview(viewSearchContainer)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        viewSearchContainer.addArrangedSubview(searchBar)
        viewSearchContainer.addArrangedSubview(imageContainer)
        
        imageContainer.addSubview(imageProfile)
        
        NSLayoutConstraint.activate([
            
            viewSearchContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            viewSearchContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            viewSearchContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            viewSearchContainer.topAnchor.constraint(equalTo: self.topAnchor),
            
            imageContainer.widthAnchor.constraint(equalToConstant: 40),
            imageContainer.heightAnchor.constraint(equalToConstant: 40),
            
            imageProfile.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor, constant: 2),
            imageProfile.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -2),
            imageProfile.topAnchor.constraint(equalTo: imageContainer.topAnchor, constant: 2),
            imageProfile.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -2)
        ])
        
        initGestureRecognizers()
        
        searchBar.delegate = self
        
    }
    
    
    private func initGestureRecognizers() {
        let tapImageContainer = UITapGestureRecognizer(target: self, action: #selector(onTapProfile))
        imageContainer.isUserInteractionEnabled = true
        imageContainer.addGestureRecognizer(tapImageContainer)
        
    }
    
    
    
    @objc private func onTapProfile() {
        debugPrint("Profile is tapped")
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        delegate?.didTapSearchBar()
        return false
    }
    

}
