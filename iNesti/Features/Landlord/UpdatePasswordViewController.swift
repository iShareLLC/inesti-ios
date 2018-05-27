//
//  UpdatePasswordViewController.swift
//  iNesti
//
//  Created by Zian Chen on 5/27/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func handleBackButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleUpdateButton(sender: UIButton) {
        //TODO: UPDATE CODE
    }

}
