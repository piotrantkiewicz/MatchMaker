import UIKit

enum Tab {
    case home
    case matches
    case inbox
    case settings
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: "Home", image: .home, tag: 0)
        case .matches:
            return UITabBarItem(title: "Matches", image: .matches, tag: 0)
        case .inbox:
            return UITabBarItem(title: "Inbox", image: .inbox, tag: 0)
        case .settings:
            return UITabBarItem(title: "Settings", image: .settings, tag: 0)
        }
    }
}
