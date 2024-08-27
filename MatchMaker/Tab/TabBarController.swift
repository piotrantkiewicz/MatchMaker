import UIKit
import DesignSystem
import MatchMakerAuth
import MatchMakerDiscovery
import MatchMakerSettings
import Swinject

class TabBarController: UITabBarController {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.tintColor = .accent
        tabBar.unselectedItemTintColor = .tabBarGray
    }
    
    private func setupViewControllers() {
        let home = setupDiscovery()
        let matches = setupMatches()
        
        let inbox = UIViewController()
        inbox.tabBarItem = Tab.inbox.tabBarItem
        
        let settings = setupSettings()
        
        viewControllers = [
            home,
            matches,
            inbox,
            settings
        ]
    }
    
    private func setupSettings() -> UIViewController {
        let navigationController = UINavigationController()
        let coordinator = SettingsCoordinator(
            navigationController: navigationController,
            container: container
        )
        
        coordinator.start()
        
        coordinator.rootViewController.tabBarItem = Tab.settings.tabBarItem
        
        return navigationController
        
    }
    
    private func setupDiscovery() -> UIViewController {
        let navigationController = UINavigationController()
        let coordinator = DiscoveryCoorinator(
            navigationController: navigationController,
            container: container
        )
        
        coordinator.start()
        
        coordinator.rootViewController.tabBarItem = Tab.home.tabBarItem
        
        return navigationController
    }
    
    private func setupMatches() -> UIViewController {
        let navigationController = UINavigationController()
        let coordinator = MatchesCoordinator(
            navigationController: navigationController,
            container: container
        )
        
        coordinator.start()
        
        coordinator.rootViewController.tabBarItem = Tab.matches.tabBarItem
        
        return navigationController
    }
}




