import UIKit
import MatchMakerCore
import Swinject

public class MatchesCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
    
    public var rootViewController: UIViewController!
    
    public init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
        
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    public func start() {
        let viewModel = MatchesViewModel(
            container: container
        )
        let controller = MatchesViewController(viewModel: viewModel)
        rootViewController = controller
        navigationController.pushViewController(controller, animated: true)
    }
}









