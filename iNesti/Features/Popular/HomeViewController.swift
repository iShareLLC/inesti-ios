//
//  HomeViewController.swift
//  iNesti
//
//  Created by Cunqi Xiao on 4/17/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import RxDataSources

class HomeViewController: BaseViewController {
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!

    private var dataSource = RentalDataStore.shared.getPopularRentals()
    private var isInitialLoading = true

    override func viewDidLoad() {
        super.viewDidLoad()

        let rental = Rental(id: 0, title: "hello", location: nil, price: nil, duration: nil, imageUrl: nil)
        RentalDataStore.shared.addPopularRental(rental: rental)
        RentalDataStore.shared.addPopularRental(rental: rental)
        
        dataSource = RentalDataStore.shared.getPopularRentals()
        tableView.delegate = self
        tableView.dataSource = self
        
        setupSearchButton()
        
        INTagHelper.shared.loadJSON()
    }
    
    private func setupSearchButton() {
        searchButton.layer.cornerRadius = 2.0
        searchButton.layer.masksToBounds = false
        searchButton.layer.applySketchShadow(color: UIColor(white: 0, alpha: 0.25), x: 0, y: 5, blur: 25, spread: 0)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RentalCell", for: indexPath) as! RentalCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppDelegate.shared().handleMainNavigation(navigationSegue: .rentalDetailSegue, sender: nil)
    }
}


