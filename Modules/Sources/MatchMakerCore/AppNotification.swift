import Foundation

public enum AppNotification: String {
    case didLoginSuccessfully
    case didLogout
}

public extension NotificationCenter {
    func post(_ appNotification: AppNotification) {
        NotificationCenter.default.post(
            Notification(name: Notification.Name(appNotification.rawValue))
        )
    }
}
