import UIKit
import MatchMakerCore
import Swinject

public class PhoneNumberCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
    
    public init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    public func start() {
        let controller = PhoneNumberViewController()
        controller.viewModel = PhoneNumberViewModel(
            container: container,
            coordinator: self
        )
        navigationController.setViewControllers([controller], animated: true)
    }
    
    func presentOTP() {
        let coordinator = OTPCoordinator(
            navigationController: navigationController,
            container: container
        )
        
        coordinator.start()
    }
}
