import UIKit

public extension UINavigationController {
    func styleMatchMaker() {
        navigationBar.tintColor = .accent
        
        let image: UIImage = UIImage(resource: .navigationBack)
        
        navigationBar.backIndicatorImage = image
        navigationBar.backIndicatorTransitionMaskImage = image
        
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
