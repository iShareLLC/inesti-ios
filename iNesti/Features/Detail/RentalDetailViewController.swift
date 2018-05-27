//
//  RentalDetailViewController.swift
//  iNesti
//
//  Created by Zian Chen on 5/26/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class RentalDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func handleBackButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension RentalDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RentalDetailSections.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RentalDetailSections.getSection(indexPath.row).defaultHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = RentalDetailSections.getSection(indexPath.row).reuseIdentifier()
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}

enum RentalDetailSections: Int {
    case image = 0
    case info = 1
    case price = 2
    case status = 3
    case spotlight = 4
    case transit = 5
    case contact = 6
    
    static func numberOfSections() -> Int {
        return 7
    }
    
    static func getSection(_ section: Int) -> RentalDetailSections {
        switch section {
        case 0:
            return image
        case 1:
            return info
        case 2:
            return price
        case 3:
            return status
        case 4:
            return spotlight
        case 5:
            return transit
        case 6:
            return contact
        default:
            return image
        }
    }
    
    func defaultHeight() -> CGFloat {
        switch self {
        case .image:
            return 170
        case .info:
            return 120
        case .price:
            return 150
        case .status:
            return 160
        case .spotlight:
            return 140
        case .transit:
            return 100
        case .contact:
            return 90
        }
    }
    
    func reuseIdentifier() -> String {
        switch self {
        case .image:
            return "RentalImageCell"
        case .info:
            return "RentalInfoCell"
        case .price:
            return "RentalPriceCell"
        case .status:
            return "RentalStatusCell"
        case .spotlight:
            return "RentalSpotlightCell"
        case .transit:
            return "RentalTransitCell"
        case .contact:
            return "RentalContactCell"
        }
    }
}
