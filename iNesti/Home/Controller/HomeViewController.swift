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
    @IBOutlet private weak var collectionView: UICollectionView!

    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfPopularPlace>!
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
        collectionView.register(cellType: PopularPlaceCell.self)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)

        dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfPopularPlace>(configureCell: { _, cv, ip, item in
            let cell = cv.dequeueReusableCell(for: ip, cellType: PopularPlaceCell.self)
            cell.setup(with: item)
            return cell
        })

        homeViewModel.popularPlaces
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 340)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? PopularPlaceCell)?.addShadow()
    }
}
