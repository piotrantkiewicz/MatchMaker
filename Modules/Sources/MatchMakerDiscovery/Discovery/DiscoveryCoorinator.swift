import UIKit
import MatchMakerCore
import Swinject

public class DiscoveryCoorinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
    
    public var rootViewController: UIViewController!
    
    public init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
        
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    public func start() {
        let viewModel = DiscoveryViewModel(
            container: container
        )
        let controller = DiscoveryViewController(viewModel: viewModel)
        rootViewController = controller
        navigationController.pushViewController(controller, animated: true)
    }
}









