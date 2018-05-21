//
//  AddRentalTypeEntryViewController.swift
//  iNesti
//
//  Created by Chen, Zian on 5/21/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class AddRentalTypeEntryViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var actionButton: UIButton!
    
    var itemCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Action Handle
    
    @IBAction func handleAddRoomButton(sender: UIButton) {
        itemCount += 1
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: UITableViewRowAnimation.bottom)
        tableView.endUpdates()
    }
}

extension AddRentalTypeEntryViewController: UITableViewDelegate {
    
}

extension AddRentalTypeEntryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
}
