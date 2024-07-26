import UIKit

public extension UINavigationController {
    static func styleMatchMaker() {
        let appearance = UINavigationBar.appearance()
        
        appearance.tintColor = .accent
        
        let image = UIImage(resource: .navigationBack)
        
        appearance.backIndicatorImage = image
        appearance.backIndicatorTransitionMaskImage = image
        appearance.barTintColor = .white
        
        appearance.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
