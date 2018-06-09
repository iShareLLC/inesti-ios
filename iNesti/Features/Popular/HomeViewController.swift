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

    private var dataSource = [RentalListItem]()
    private var isInitialLoading = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchButton.layer.cornerRadius = 2.0
        searchButton.layer.masksToBounds = false
        searchButton.layer.applySketchShadow(color: UIColor(white: 0, alpha: 0.25), x: 0, y: 5, blur: 25, spread: 0)
        
        INTagHelper.shared.loadJSON()
        
        //APITester().testRentalList()
        //Add pagination
        APIManager.shared.getRentalList(city: "nyc", start: 0, limit: 15) { (object, error) in
            if let object = object {
                self.dataSource.append(contentsOf: object.results)
                self.tableView.reloadData()
            }
        }
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
        let item = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RentalCell", for: indexPath) as! RentalCell
        cell.setup(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppDelegate.shared().handleMainNavigation(navigationSegue: .rentalDetailSegue, sender: nil)
    }
}


