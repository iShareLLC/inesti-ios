//
//  SearchResultViewController.swift
//  iNesti
//
//  Created by Zian Chen on 5/26/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultMessageLabel: UILabel!
    
    //var rentalDataSource = [Rental]()
    var rentalDataSource = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        resultMessageLabel.text = "搜索到\(rentalDataSource.count)个可靠房源"
    }
    
    //MARK: - Action Handler
    
    @IBAction func handleBackButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentalDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RentalCell", for: indexPath) as! RentalCell
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
}
