//
//  LocationInputView.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/2/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import CXPopupKit
import Reusable
import RxSwift
import RxCocoa

class LocationInputView: UIView, NibLoadable {
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var locationTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!

    private let locationInputViewModel = LocationInputViewModel()
    private let disposeBag = DisposeBag()

    private let appearance: CXAppearance = {
        var appearance = CXAppearance()
        appearance.window.width = .equalToParent
        appearance.window.height = .equalToParent
        appearance.window.position = .center
        appearance.window.allowTouchOutsideToDismiss = false
        appearance.window.isSafeAreaEnabled = true
        appearance.window.enableInsideSafeArea = true
        appearance.window.backgroundColor = .white
        appearance.animation.style = .plain
        appearance.animation.transition = CXAnimation.Transition(.center)
        appearance.animation.duration = CXAnimation.Duration(0.35)
        return appearance
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "location")
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 63

        locationInputViewModel.dataSource
            .bind(to: tableView.rx.items(cellIdentifier: "location", cellType: UITableViewCell.self)) { row, item, cell in
                cell.textLabel?.text = item
                cell.textLabel?.font = UIFont(name: "PingFangSC-Regular", size: 18)

                if row == 0 {
                    cell.textLabel?.textColor = UIColor(red: 1, green: 157 / 255.0, blue: 2 / 255.0, alpha: 1)
                } else {
                    cell.textLabel?.textColor = UIColor(red: 102 / 255.0, green: 102 / 255.0, blue: 102 / 255.0, alpha: 1)
                }
            }
            .disposed(by: disposeBag)

        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.popup?.completeWithNegative(result: nil)
            })
            .disposed(by: disposeBag)

        locationTextField.becomeFirstResponder()
    }
}

extension LocationInputView: CXPopupable {
    func createPopup() -> CXPopup {
        return CXPopup(with: self, appearance: appearance)
    }
}
