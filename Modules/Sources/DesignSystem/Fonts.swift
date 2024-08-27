import UIKit

public enum Fonts: String {
    case poppinsRegular = "Poppins-Regular"
    case poppinsBold = "Poppins-Bold"
    case avenirNextRegular = "AvenirNext-Regular"
    case avenirNextDemiBold = "AvenirNext-DemiBold"
    case avenirNextBold = "AvenirNext-Bold"
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
    
    static var title2: UIFont {
        UIFont(name: Fonts.avenirNextDemiBold.rawValue, size: 20)!
    }
    
    static var subtitle2: UIFont {
        UIFont(name: Fonts.avenirNextRegular.rawValue, size: 15)!
    }
    
    static var textField: UIFont {
        UIFont(name: Fonts.avenirMedium.rawValue, size: 18)!
    }
    
    static var textField2: UIFont {
        UIFont(name: Fonts.avenirMedium.rawValue, size: 15)!
    }
    
    static var button: UIFont {
        UIFont(name: Fonts.avenirBlack.rawValue, size: 20)!
    }
    
    static var button2: UIFont {
        UIFont(name: Fonts.avenirNextBold.rawValue, size: 22)!
    }
    
    static var otp: UIFont {
        UIFont(name: Fonts.avenirBlack.rawValue, size: 24)!
    }
    
    static var codeLabel: UIFont {
        UIFont(name: Fonts.poppinsRegular.rawValue, size: 16)!
    }
    
    static var resendLabel: UIFont {
        UIFont(name: Fonts.poppinsBold.rawValue, size: 16)!
    }
    
    static var navigationTitle: UIFont {
        UIFont(name: Fonts.avenirNextBold.rawValue, size: 25)!
    }
    
    static var navigationTitle2: UIFont {
        UIFont(name: Fonts.avenirNextBold.rawValue, size: 30)!
    }
    
    static var cardTitle: UIFont {
        UIFont(name: Fonts.avenirNextBold.rawValue, size: 30)!
    }
}







