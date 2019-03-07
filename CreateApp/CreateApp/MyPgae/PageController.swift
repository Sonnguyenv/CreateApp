//
//  PageController.swift
//  CreateApp
//
//  Created by Sonnv on 3/6/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import UIKit

class PageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoingVC") as! GoingVC
    let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WentVC") as! WentVC
    
    lazy var viewControllerList = [vc1, vc2]
    
    weak var colorButtonDelegate: ColorButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vc1.colorButtonDelegate = self as? ColorButtonDelegate
        vc2.colorButtonDelegate = self as? ColorButtonDelegate
        
        self.dataSource = self
        self.delegate = self
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func moveToPage(_ index: Int) {
        if index == 0 {
            setViewControllers([viewControllerList[0]], direction: .reverse, animated: true, completion: nil)
        } else {
            setViewControllers([viewControllerList[1]], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerList.count > previousIndex else {return nil}
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard viewControllerList.count != nextIndex else {return nil}
        guard viewControllerList.count > nextIndex else {return nil}
        return viewControllerList[nextIndex]
    }
}

extension PageController: ColorButtonDelegate {
    func colorButton(_ index: Int) {
        colorButtonDelegate?.colorButton(index)
    }
}
