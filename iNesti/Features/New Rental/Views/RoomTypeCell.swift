//
//  RoomTypeCell.swift
//  iNesti
//
//  Created by Chen, Zian on 5/21/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class RoomTypeCell: UITableViewCell {

    var rentalType: RentalType?
    var index: Int = 0
    
    @IBOutlet weak var roomTypeTextField: UITextField!
    @IBOutlet weak var bedroomCountTextField: UITextField!
    @IBOutlet weak var showerCountTextField: UITextField!
    @IBOutlet weak var rentTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
