
import UIKit

class PageViewController: UIPageViewController {
    
    var currentIndex = 0
    
    lazy var subViewControllers: [UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsVC") as! NewsVC,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopularVC") as! PopularVC
//            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventsVC") as! EventsVC
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func moveToPage(_ index: Int) {
        switch index {
        case 0:
            setViewControllers([subViewControllers[0]], direction: .reverse, animated: true, completion: nil)
            currentIndex = 0
        default:
            setViewControllers([subViewControllers[1]], direction: .forward, animated: true, completion: nil)
//        default:
//            setViewControllers([subViewControllers[2]], direction: .forward, animated: true, completion: nil)
//            currentIndex = 2
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.index(of: viewController) ?? 0
        if currentIndex <= 0 {
            return nil
        }
        return subViewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.index(of: viewController) ?? 0
        if currentIndex >= subViewControllers.count-1 {
            return nil
        }
        return subViewControllers[currentIndex+1]
    }
}
