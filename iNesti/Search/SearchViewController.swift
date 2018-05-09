//
//  SearchViewController.swift
//  iNesti
//
//  Created by Cunqi Xiao on 4/26/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import CXPopupKit
import RxSwift
import RxCocoa
import Reusable
import TTRangeSlider

class SearchViewController: BaseViewController, CXStoryboardLoadable {
    @IBOutlet private weak var addressTextField: UITextField!
    @IBOutlet private weak var addressTextInputButton: UIButton!
    @IBOutlet private weak var datePickerButton: UIButton!
    @IBOutlet private weak var durationPickerButton: UIButton!
    @IBOutlet private weak var showResultButton: UIButton!
    @IBOutlet private weak var rangeLabel: UILabel!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private var roomTypeButtons: [UIButton]!
    @IBOutlet private weak var rangeSlider: TTRangeSlider!

    override func viewDidLoad() {
        addressTextInputButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.showLocationInputView()
            })
            .disposed(by: disposeBag)

        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        datePickerButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.showDatePicker()
            })
            .disposed(by: disposeBag)

        durationPickerButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.showDurationPicker()
            })
            .disposed(by: disposeBag)

        setupRangeSlider()
        setupShowResultButton()
        setupRoomTypeButtons()
    }
    private func setupRangeSlider() {
        rangeSlider.handleBorderWidth = 1
        rangeSlider.handleColor = .white
        rangeSlider.handleDiameter = 25
        rangeSlider.selectedHandleDiameterMultiplier = 1.1
        rangeSlider.handleBorderColor = UIColor.majorYellow
        rangeSlider.minValue = 0
        rangeSlider.maxValue = 10000
        rangeSlider.step = 50
        rangeSlider.enableStep = true
        rangeSlider.selectedMaximum = 10000
        rangeSlider.addTarget(self, action: #selector(didChangeSliderValue(_:)), for: .valueChanged)
    }

    @objc private func didChangeSliderValue(_ sender: TTRangeSlider) {
        rangeLabel.text = "$\(Int(sender.selectedMinimum)) - $\(Int(sender.selectedMaximum))"
    }

    private func setupShowResultButton() {
        showResultButton.layer.cornerRadius = 3.0
        showResultButton.layer.masksToBounds = false
        showResultButton.layer.applySketchShadow(color: UIColor(white: 0, alpha: 0.13), x: 0, y: 2, blur: 3, spread: 0)
    }

    private func showLocationInputView() {
        let locationInputView = LocationInputView.loadFromNib()
        let popup = locationInputView.createPopup()
        popup.positiveAction = { result in
            guard let location = result as? String else {
                return
            }
        }
        popup.show(at: self)
    }

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

    private func setupRoomTypeButtons() {
        func unselectRoomType() {
            roomTypeButtons.forEach { $0.isSelected = false  }
        }

        for button in roomTypeButtons {
            button.rx.tap.subscribe(onNext: { _ in
                unselectRoomType()
                button.isSelected = true
            })
            .disposed(by: disposeBag)
        }
    }

    private func showDurationPicker() {
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
    }
}
