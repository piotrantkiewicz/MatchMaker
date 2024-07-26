import UIKit

public extension UIButton {
    func styleMatchMaker() {
        titleLabel?.font = .button
        titleLabel?.textColor = .white

        layer.cornerRadius = 14
        layer.masksToBounds = true

        applyGradient(colours: [
                UIColor(resource: .accent),
                UIColor(resource: .backgroundPink)
        ])
    }
}
