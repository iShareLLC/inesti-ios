//
//  HomeViewController.swift
//  iNesti
//
//  Created by Cunqi Xiao on 4/17/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchButton()
    }

    private func setupSearchButton() {
        searchButton.layer.cornerRadius = 2.0
        searchButton.layer.masksToBounds = false
        searchButton.layer.shadowColor = UIColor(white: 0, alpha: 0.25).cgColor
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        searchButton.layer.shadowOpacity = 1
        searchButton.layer.shadowRadius = 25 / 2.0
        searchButton.layer.shadowPath = UIBezierPath(roundedRect: searchButton.bounds, cornerRadius: 2).cgPath
    }
}
