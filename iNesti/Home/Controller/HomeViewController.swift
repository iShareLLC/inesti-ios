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
    private var isInitialLoading = true

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchButton()
        setupCollectionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        /*
        if isInitialLoading {
            let loadingView = SplashLoadingView.loadFromNib().createPopup()
            loadingView.show(at: self)
            homeViewModel.requestPopularPlaces { success in
                loadingView.completeWithPositive(result: nil)
            }
            isInitialLoading = false
        }
 */
    }

    private func setupSearchButton() {
        searchButton.layer.cornerRadius = 2.0
        searchButton.layer.masksToBounds = false
        searchButton.layer.applySketchShadow(color: UIColor(white: 0, alpha: 0.25), x: 0, y: 5, blur: 25, spread: 0)
        searchButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                //if let searchVC = R.storyboard.main.searchViewController() {
                // self?.present(searchVC, animated: true, completion: nil)
                //}
            })
            .disposed(by: disposeBag)
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

        tableView.rx.modelSelected(PopularPlace.self)
            .subscribe(onNext: { [weak self] _ in
                if let roomDetailNav = self?.storyboard?.instantiateViewController(withIdentifier: "RoomDetailNav") {
                    self?.present(roomDetailNav, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
