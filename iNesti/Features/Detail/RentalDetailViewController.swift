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
    @IBOutlet weak var containerView: UIView!
    
    weak var contactViewController: RentalContactViewController!
    var isContactShown: Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.isContactShown {
                    self.containerView.isHidden = false
                    UIView.animate(withDuration: 0.3, animations: {
                        self.containerView.alpha = 1
                    })
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.containerView.alpha = 0
                    }) { (completed) in
                        self.containerView.isHidden = true
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerView.isHidden = true
        self.containerView.alpha = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 140;
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewContrller = segue.destination as? RentalContactViewController {
            contactViewController = viewContrller
            contactViewController.delegate = self
        }
    }

    @IBAction func handleBackButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleContactButton(sender: UIButton) {
        isContactShown = true
    }
}

extension RentalDetailViewController: RentalContactViewControllerDelegate {
    func handleDismiss() {
        isContactShown = false
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
        
        if reuseId == "RentalStatusCell" {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! INBasicInfoCell
            
            //var itemArray = [INBasicItemInfo]()
            let info1 = INBasicItemInfo(name: "租金包含网费", isAvaialble: true)
            let info2 = INBasicItemInfo(name: "可养狗", isAvaialble: false)
            let info3 = INBasicItemInfo(name: "租金包含网费", isAvaialble: true)
            let info4 = INBasicItemInfo(name: "可养猫", isAvaialble: true)
            let info5 = INBasicItemInfo(name: "租金包含水费", isAvaialble: false)
            let info6 = INBasicItemInfo(name: "禁止吸烟", isAvaialble: true)
            let info7 = INBasicItemInfo(name: "租金包含燃气费", isAvaialble: false)
            let info8 = INBasicItemInfo(name: "洗衣机", isAvaialble: false)
            let info9 = INBasicItemInfo(name: "24小时门卫", isAvaialble: true)
            let info10 = INBasicItemInfo(name: "烘干机", isAvaialble: false)
            
            cell.setItemInfo(itemInfo: [info1, info2, info3, info4, info5, info6, info7, info8, info9, info10])
            return cell
            
        } else if (reuseId == "RentalSpotlightCell") {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! INSpotlightInfoCell
            let info1 = INSpotlightItemInfo(name: "空调", iconName: "ac")
            let info2 = INSpotlightItemInfo(name: "工作台", iconName: "workstation")
            let info3 = INSpotlightItemInfo(name: "游泳池", iconName: "swimming-pool")
            let info4 = INSpotlightItemInfo(name: "打印机", iconName: "print")
            let info5 = INSpotlightItemInfo(name: "健身房", iconName: "gym")
            let info6 = INSpotlightItemInfo(name: "显示器", iconName: "monitor")
            let info7 = INSpotlightItemInfo(name: "热水", iconName: "shower")
            let info8 = INSpotlightItemInfo(name: "查看更多", iconName: "")
            
            cell.setItemInfo(itemInfo: [info1, info2, info3, info4, info5, info6, info7, info8])
            return cell
            
        } else if (reuseId == "RentalTransitCell") {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! INTrafficItemInfoCell
            let info1 = INSpotlightItemInfo(name: "地铁D", iconName: "subway")
            let info2 = INSpotlightItemInfo(name: "PATH", iconName: "metro")
            
            let traffic1 = "13分钟步行至 Brighton Beach"
            let traffic2 = "5分钟步行至 Chinatown"
            cell.setItemInfo(itemInfo: [info1, info2], trafficInfo: [traffic1, traffic2])
            return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
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
            return 200
        case .spotlight:
            return 160
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
