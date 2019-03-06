//
//  PageController.swift
//  CreateApp
//
//  Created by Sonnv on 3/6/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import UIKit

class PageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    weak var delegatColor: ChangeColor?
    
    lazy var viewControllerList:[UIViewController] = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "GoingVC")
        let vc2 = sb.instantiateViewController(withIdentifier: "WentVC")
        return [vc1, vc2]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        delegatColor?.colorbutton(index: vcIndex)
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerList.count > previousIndex else {return nil}
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        delegatColor?.colorbutton(index: vcIndex)
        let nextIndex = vcIndex + 1
        guard viewControllerList.count != nextIndex else {return nil}
        guard viewControllerList.count > nextIndex else {return nil}
        return viewControllerList[nextIndex]
    }
}

protocol ChangeColor: class {
    func colorbutton(index: Int)
}
