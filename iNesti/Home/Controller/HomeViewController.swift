//
//  HomeViewController.swift
//  iNesti
//
//  Created by Cunqi Xiao on 4/17/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import RxDataSources

class HomeViewController: BaseViewController {
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!

    private var dataSource: RxTableViewSectionedReloadDataSource<SectionOfPopularPlace>!
    private let homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchButton()
        setupCollectionView()
        homeViewModel.requestPopularPlaces()
    }

    private func setupSearchButton() {
        searchButton.layer.cornerRadius = 2.0
        searchButton.layer.masksToBounds = false
        searchButton.layer.applySketchShadow(color: UIColor(white: 0, alpha: 0.25), x: 0, y: 5, blur: 25, spread: 0)
    }

    private func setupCollectionView() {
        tableView.register(cellType: PopularPlaceCell.self)
//        tableView.rx.setDelegate(self).disposed(by: disposeBag)

        dataSource = RxTableViewSectionedReloadDataSource<SectionOfPopularPlace>(configureCell: { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: PopularPlaceCell.self)
            cell.setup(with: item)
            cell.addShadow()
            return cell
        })

        homeViewModel.popularPlaces
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
