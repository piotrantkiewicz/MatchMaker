import UIKit

public final class SettingsViewModel {
    
    struct Header {
        let image: UIImage
        let name: String
        let location: String
    }
    
    let header: Header
    
    public init() {
        header = Header(
            image: UIImage(resource: .profilePicturePlaceholder),
            name: "Setup Your Name",
            location: "No Location"
        )
    }
    
}
