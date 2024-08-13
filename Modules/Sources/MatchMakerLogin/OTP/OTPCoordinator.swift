import UIKit
import MatchMakerCore
import Swinject

public class OTPCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
    
    public init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    public func start() {
        let viewController = OTPViewController()
        viewController.viewModel = OTPViewModel(container: container)
        navigationController.pushViewController(viewController, animated: true)
    }
}
