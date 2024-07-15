import UIKit

public enum Fonts: String {
    case poppinsBold = "Poppins-Bold"
    case avenirNextRegular = "AvenirNext-Regular"
    case avenirMedium = "AvenirNext-Medium"
    case avenirBlack = "Avenir-Black"
}

public extension UIFont {
    static var title: UIFont {
        UIFont(name: Fonts.poppinsBold.rawValue, size: 45)!
    }
    
    static var subtitle: UIFont {
        UIFont(name: Fonts.avenirNextRegular.rawValue, size: 18)!
    }
    
    static var textField: UIFont {
        UIFont(name: Fonts.avenirMedium.rawValue, size: 18)!
    }
    
    static var button: UIFont {
        UIFont(name: Fonts.avenirBlack.rawValue, size: 20)!
    }
}
