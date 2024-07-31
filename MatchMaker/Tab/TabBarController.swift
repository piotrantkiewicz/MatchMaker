import UIKit
import DesignSystem
import MatchMakerAuth
import MatchMakerSettings

class TabBarController: UITabBarController {
    
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
        let home = UIViewController()
        home.tabBarItem = Tab.home.tabBarItem
        
        let matches = UIViewController()
        matches.tabBarItem = Tab.matches.tabBarItem
        
        let inbox = UIViewController()
        inbox.tabBarItem = Tab.inbox.tabBarItem
        
        let settings = setupSettings()
        
        viewControllers = [
            home,
            matches,
            inbox,
            settings
        ]
        
        selectedViewController = settings
    }
    
    private func setupSettings() -> UIViewController {
        let settings = SettingsViewController()
        let authService = AuthServiceLive()
        let profilePictureService = UserProfileRepositoryLive(authService: authService)
        settings.viewModel = SettingsViewModel(
            authService: authService,
            userProfileRepository: profilePictureService,
            profilePictureRepository: ProfilePictureRepositoryLive(
                authService: authService,
                userProfileRepository: profilePictureService
            )
        )
        let settingsNav = UINavigationController(rootViewController: settings)
        settings.tabBarItem = Tab.settings.tabBarItem
        
        return settingsNav
    }
}
