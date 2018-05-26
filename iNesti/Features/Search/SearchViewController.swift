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
    
    let typeAheadData = ["Chinatown", "Woodhaven", "East Village", "Soho", "Brooklyn", "Flushing", "Roosevelt Island", "Elmhurst"]
    let kSearchResultSegue = "SearchResultSegue"
    
    var typeAheadResults = [String]() {
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

    private func showLocationInputView() {
        /*
        let locationInputView = LocationInputView.loadFromNib()
        let popup = locationInputView.createPopup()
        popup.positiveAction = { result in
            guard let location = result as? String else {
                return
            }
        }
        popup.show(at: self)
 */
    }

    /*
    private func showDatePicker() {
        let datePicker = CXDatePicker(startDate: Date(), mode: .date, title: "开始时间", cancelButtonText: "取消", doneButtonText: "确认")
        let popup = datePicker.createPopup()
        popup.positiveAction = { [weak self] result in
            guard let date = result as? Date else {
                return
            }
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            let dateString = formatter.string(from: date)
            self?.datePickerButton.setTitle(dateString, for: .normal)
        }
        popup.show(at: self)
    }
     */
    
    private func showDurationPicker() {
        /*
        let range = (1 ... 20).map { "\($0)" }
        let durationPicker = CXPicker(with: [range, ["天", "周", "月"]], title: "租期", cancelButtonText: "取消", doneButtonText: "确认")
        let popup = durationPicker.createPopup()
        popup.positiveAction = { [weak self] options in
            guard let items = options as? [String] else {
                return
            }
            let title = "\(items[0])\(items[1])"
            self?.durationPickerButton.setTitle(title, for: .normal)
        }
        popup.show(at: self)
         */
    }
    
    
    //MARK: Action Handler
    
    @objc private func didChangeSliderValue(_ sender: TTRangeSlider) {
        rangeLabel.text = "$\(Int(sender.selectedMinimum)) - $\(Int(sender.selectedMaximum))"
    }
    
    @IBAction func handleSearchButton(sender: UIButton) {
        
        //TODO: Add Search API
        
        performSegue(withIdentifier: kSearchResultSegue, sender: nil)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeAheadResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTypeAheadCell", for: indexPath)
        cell.textLabel?.text = typeAheadResults[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addressTextField.text = typeAheadResults[indexPath.row]
        typeAheadResults.removeAll()
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        typeAheadResults = typeAheadData.filter({ (location) -> Bool in
            if let text = textField.text {
                return (location.lowercased().range(of: text) != nil)
            } else {
                return false
            }
        })
    }
    
}
