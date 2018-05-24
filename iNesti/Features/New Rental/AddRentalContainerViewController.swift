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
    @IBOutlet weak var backButton: UIButton!
    
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
            addRentalPageController.navigateToPreviousPage { [weak self] (index) in
                guard let strongSelf = self else { return }
                strongSelf.checkNextButtonEnabled(index: index)
            }
        }
    }

    @IBAction func handleSaveButton(sender: UIButton) {
        save()
    }
    
    @IBAction func handleNextButton(sender: UIButton) {
        
        if addRentalPageController.getCurrentIndex() == addRentalPageController.numberOfPages() - 1 {
            //Last page
            //TODO: Publish
            publish()
            
        } else {
            addRentalPageController.navigateToNextPage { [weak self] (index) in
                guard let strongSelf = self else { return }
                strongSelf.checkNextButtonEnabled(index: index)
            }
        }
        
    }
    
    private func checkNextButtonEnabled(index: Int) {
//        if index == addRentalPageController.numberOfPages() - 1 {
//            nextButton.isUserInteractionEnabled = false
//            nextButton.alpha = 0.3
//        } else {
//            nextButton.isUserInteractionEnabled = true
//            nextButton.alpha = 1
//        }
        
        backButton.isHidden = (index == 0)
        
        if index == addRentalPageController.numberOfPages() - 1 {
            nextButton.setTitle("发布", for: .normal)
        } else {
            nextButton.setTitle("下一步", for: .normal)
        }
    }
    
    private func publish() {
        
        let rental = Rental(id: 0, title: "hello", location: nil, price: nil, duration: nil, imageUrl: nil)
        RentalDataStore.shared.addRental(rental: rental, state: .published)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    private func save() {
        
        //let rental = Rental(id: 0, title: "hello", location: nil, price: nil, duration: nil, imageUrl: nil)
        //RentalDataStore.shared.addRental(rental: rental, state: .unpublish)
        
        self.dismiss(animated: true, completion: nil)
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