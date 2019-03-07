
import UIKit

class TabBarVC: UITabBarController {
    
    static let instance = TabBarVC()
    let keyChain = KeychainSwift()

    var subViewControllers: [String: UIViewController] = {
        return ["homeVC": UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") ,
                "nearVC": UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NearVC")  ,
                "browsVC": UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BrowsVC") ,
                "myPageVC": UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") ,
                "myEventsVC": UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyEventsVC")
        ]
    }()

    lazy var homeVC = subViewControllers["homeVC"]
    lazy var nearVC = subViewControllers["nearVC"]
    lazy var searchVC = subViewControllers["browsVC"]
    lazy var myPageVC = subViewControllers["myPageVC"]
    lazy var meVC = subViewControllers["myEventsVC"]

    override func viewDidLoad() {
        super.viewDidLoad()
        homeVC?.tabBarItem.title = "Home"
        nearVC?.tabBarItem.title = "Near"
        myPageVC?.tabBarItem.title = "My Page"
        meVC?.tabBarItem.title = "Me"
        undateTabBar()
    }
    
    func undateTabBar() {
        let navgationMyPage = UINavigationController.init(rootViewController: myPageVC!)
        navgationMyPage.tabBarItem.title = "My Page"
        navgationMyPage.navigationBar.isHidden = true
        let navigationSearch = UINavigationController.init(rootViewController: searchVC!)
        navigationSearch.tabBarItem.title = "Search"
        navigationSearch.navigationBar.isHidden = true
        
        if keyChain.get("token") != nil {
            viewControllers = [homeVC!, nearVC!, navigationSearch, meVC!]
        } else {
            viewControllers = [homeVC!, nearVC!, navigationSearch, navgationMyPage]
        }
    }
}
