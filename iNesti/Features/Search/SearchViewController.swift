//
//  SearchViewController.swift
//  iNesti
//
//  Created by Cunqi Xiao on 4/26/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import TTRangeSlider
import DropDown

class SearchViewController: BaseViewController {
    @IBOutlet weak var addressTextField: INTextField!
    @IBOutlet weak var startDateTextField: INTextField!
    @IBOutlet weak var durationTextField: INTextField!
    @IBOutlet weak var showResultButton: UIButton!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var rangeSlider: TTRangeSlider!
    
    @IBOutlet weak var typeAheadTableView: UITableView!
    @IBOutlet weak var typeAheadTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var periodButton: UIButton!
    
    var typeAheadData = [INLocation]()
    let kSearchResultSegue = "SearchResultSegue"
    
    var typeAheadResults = [INLocation]() {
        didSet {
            if self.isViewLoaded {
                typeAheadTableView.reloadData()
                if typeAheadResults.count > 0 {
                    typeAheadTableViewConstraint.constant = 300
                } else {
                    typeAheadTableViewConstraint.constant = 0
                }
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {

        typeAheadData = INTagHelper.shared.locations
        
        typeAheadTableView.delegate = self
        typeAheadTableView.dataSource = self
        
        addressTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

//        datePickerButton.rx.tap
//            .subscribe({ [weak self] _ in
//                //self?.showDatePicker()
//            })
//            .disposed(by: disposeBag)

//        durationPickerButton.rx.tap
//            .subscribe(onNext: { [weak self] _ in
//                self?.showDurationPicker()
//            })
//            .disposed(by: disposeBag)
        
        //Range Slider
        rangeSlider.handleBorderWidth = 1
        rangeSlider.handleColor = .white
        rangeSlider.handleDiameter = 25
        rangeSlider.selectedHandleDiameterMultiplier = 1.1
        rangeSlider.handleBorderColor = UIColor.in_yellow
        rangeSlider.minValue = 0
        rangeSlider.maxValue = 10000
        rangeSlider.step = 50
        rangeSlider.enableStep = true
        rangeSlider.selectedMaximum = 10000
        rangeSlider.addTarget(self, action: #selector(didChangeSliderValue(_:)), for: .valueChanged)
        rangeSlider.hideLabels = true
        
        //Show Result Button
        showResultButton.layer.cornerRadius = 3.0
        showResultButton.layer.masksToBounds = false
        showResultButton.layer.applySketchShadow(color: UIColor(white: 0, alpha: 0.13), x: 0, y: 2, blur: 3, spread: 0)
    }


    //MARK: Action Handler
    
    @objc private func didChangeSliderValue(_ sender: TTRangeSlider) {
        rangeLabel.text = "$\(Int(sender.selectedMinimum)) - $\(Int(sender.selectedMaximum))"
    }
    
    @IBAction func handleSearchButton(sender: UIButton) {
        
        //TODO: Add Search API
        
        performSegue(withIdentifier: kSearchResultSegue, sender: nil)
    }
    
    @IBAction func handlePeriodButton(sender: UIButton) {
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource = ["月", "日", "年"]
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.periodButton.setTitle("/ \(item)", for: .normal)
        }
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.show()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeAheadResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTypeAheadCell", for: indexPath)
        cell.textLabel?.text = typeAheadResults[indexPath.row].displayName
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addressTextField.text = typeAheadResults[indexPath.row].displayName
        typeAheadResults.removeAll()
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        typeAheadResults = typeAheadData.filter({ (location) -> Bool in
            if let text = textField.text {
                return (location.location.lowercased().range(of: text) != nil)
            } else {
                return false
            }
        })
    }
    
}
