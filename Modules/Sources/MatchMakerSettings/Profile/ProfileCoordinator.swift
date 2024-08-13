import UIKit
import MatchMakerCore
import Swinject

public class ProfileCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
    
    public init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    public func start() {
        let controller = ProfileViewController()
        controller.viewModel = ProfileViewModel(
            container: container,
            coordinator: self
        )
        controller.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(controller, animated: true)
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
