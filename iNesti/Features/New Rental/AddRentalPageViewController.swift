//
//  AddRentalPageViewController.swift
//  iNesti
//
//  Created by Chen, Zian on 5/21/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class AddRentalPageViewController: UIPageViewController {

    var viewControllerArray = [UIViewController]()
    var locationViewController: AddRentalLocationViewController?
    var typeEntryViewController: AddRentalTypeEntryViewController?
    var tagEntryViewController: AddRentalTagEntryViewController?
    var imagesViewController: AddRentalImagesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        let locationViewController = INUtilities.instantiateViewContorller(id: "AddRentalLocationViewController", storyboardId: "NewRental")
        let typeEntryViewController = INUtilities.instantiateViewContorller(id: "AddRentalTypeEntryViewController", storyboardId: "NewRental")
        let tagEntryViewController = INUtilities.instantiateViewContorller(id: "AddRentalTagEntryViewController", storyboardId: "NewRental")
        let imagesViewController = INUtilities.instantiateViewContorller(id: "AddRentalImagesViewController", storyboardId: "NewRental")
        
        viewControllerArray = [locationViewController, typeEntryViewController, tagEntryViewController, imagesViewController]
        
        if let firstViewController = viewControllerArray.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AddRentalPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerArray.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard viewControllerArray.count > previousIndex else {
            return nil
        }
        
        return viewControllerArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerArray.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let viewControllerCount = viewControllerArray.count
        
        guard viewControllerCount != nextIndex else {
            return nil
        }
        
        guard viewControllerCount > nextIndex else {
            return nil
        }
        
        return viewControllerArray[nextIndex]
    }
}
