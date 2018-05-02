//
//  SearchViewController.swift
//  iNesti
//
//  Created by Cunqi Xiao on 4/26/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import CXPopupKit

class SearchViewController: BaseViewController, CXStoryboardLoadable {
    @IBOutlet private weak var addressTextField: UITextField!
    @IBOutlet private weak var datePickerButton: UIButton!
    @IBOutlet private weak var durationPickerButton: UIButton!
    @IBOutlet private weak var showResultButton: UIButton!
    @IBOutlet private weak var rangeLabel: UILabel!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private var roomTypeButtons: [UIButton]!

}
