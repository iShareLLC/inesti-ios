//
//  AddRentalContainerViewController.swift
//  iNesti
//
//  Created by Chen, Zian on 5/21/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class AddRentalContainerViewController: BaseViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    let addRentalPageEmbedId = "AddRentalPageEmbed"
    weak var addRentalPageController: AddRentalPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = 4
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == addRentalPageEmbedId, let pageViewController = segue.destination as? AddRentalPageViewController {
            addRentalPageController = pageViewController
            //addRentalPageController.addRentalPageDelegate = self
        }
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Action Handler
    @IBAction func handleBackButton(sender: UIButton) {
        if addRentalPageController.getCurrentIndex() == 0 {
            self.dismiss(animated: true, completion: nil)
        } else {
            addRentalPageController.navigateToPreviousPage { (index) in
                DLog("index: \(index)")
            }
        }
    }

    @IBAction func handleSaveButton(sender: UIButton) {
        
    }
    
    @IBAction func handleNextButton(sender: UIButton) {
        addRentalPageController.navigateToNextPage { [weak self] (index) in
            DLog("index: \(index)")
            guard let strongSelf = self else { return }
            
            if index == strongSelf.addRentalPageController.numberOfPages() - 1 {
                strongSelf.nextButton.isUserInteractionEnabled = false
                strongSelf.nextButton.alpha = 0.3
            } else {
                strongSelf.nextButton.isUserInteractionEnabled = true
                strongSelf.nextButton.alpha = 1
            }
        }
    }
}

//extension AddRentalContainerViewController: AddRentalPageViewControllerDelegate {
//
//    func addRentalPageUpdate(index: Int) {
//        pageControl.currentPage = index
//
//        if index == addRentalPageController.numberOfPages() - 1 {
//            nextButton.isUserInteractionEnabled = false
//            nextButton.alpha = 0.3
//        } else {
//            nextButton.isUserInteractionEnabled = true
//            nextButton.alpha = 1
//        }
//    }
//}
