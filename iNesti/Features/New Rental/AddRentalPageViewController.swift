//
//  AddRentalPageViewController.swift
//  iNesti
//
//  Created by Chen, Zian on 5/21/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

protocol AddRentalPageViewControllerDelegate: class {
    func addRentalPageUpdate(index: Int)
}

class AddRentalPageViewController: UIPageViewController {

    private var viewControllerArray = [UIViewController]()
    private var locationViewController: AddRentalLocationViewController?
    private var typeEntryViewController: AddRentalTypeEntryViewController?
    private var tagEntryViewController: AddRentalTagEntryViewController?
    private var imagesViewController: AddRentalImagesViewController?
    weak var addRentalPageDelegate: AddRentalPageViewControllerDelegate?
    //var pendingIndex: Int = 0
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
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
        
        removeSwipeGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func removeSwipeGesture(){
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    
    public func numberOfPages() -> Int {
        return viewControllerArray.count
    }
    
    public func navigateToPreviousPage(completion:((Int) -> Void)?) {
        let nextIndex = currentIndex - 1
        if nextIndex < viewControllerArray.count {
            let viewController = viewControllerArray[nextIndex]
            self.setViewControllers([viewController], direction: .reverse, animated: true, completion: nil)
            currentIndex = nextIndex
            completion?(currentIndex)
        }
    }
    
    public func navigateToNextPage(completion:((Int) -> Void)?) {
        let nextIndex = currentIndex + 1
        if nextIndex < viewControllerArray.count {
            let viewController = viewControllerArray[nextIndex]
            self.setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
            currentIndex = nextIndex
            completion?(currentIndex)
        }
    }
    
    public func getCurrentIndex() -> Int {
        return currentIndex
    }
}

extension AddRentalPageViewController: UIPageViewControllerDelegate {
    
//    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
//        if let viewController = pendingViewControllers.first, let index = viewControllerArray.index(of: viewController) {
//            pendingIndex = index
//        }
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        if completed {
//            currentIndex = pendingIndex
//            addRentalPageDelegate?.addRentalPageUpdate(index: currentIndex)
//        }
//    }
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
