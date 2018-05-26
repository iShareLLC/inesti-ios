//
//  AddRentalLocationViewController.swift
//  iNesti
//
//  Created by Chen, Zian on 5/21/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class AddRentalLocationViewController: BaseViewController {

    @IBOutlet var locationTextField: INTextField!
    @IBOutlet var titleTextField: INTextField!
    @IBOutlet var areaTextField: INTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //locationTextField.setBottomBorder()
        //titleTextField.setBottomBorder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
