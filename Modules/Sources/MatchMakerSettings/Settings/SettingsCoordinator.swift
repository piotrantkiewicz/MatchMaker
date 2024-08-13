import UIKit
import MatchMakerCore
import Swinject

public class SettingsCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
    
    public var rootViewController: UIViewController!
    
    public init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    public func start() {
        let controller = SettingsViewController()
        controller.viewModel = SettingsViewModel(container: container, coordinator: self)
        navigationController.setViewControllers([controller], animated: false)
        
        rootViewController = controller
    }
    
    func presentProfileEdit() {
        let coordinator = ProfileCoordinator(
            navigationController: navigationController,
            container: container
        )
        
        coordinator.start()
    }
}
