import UIKit

enum TextFieldType {
    case name
    case location
}

enum Row {
    case profilePicture
    case textField(TextFieldType)
}

public final class ProfileViewModel {
    var selectedImage: UIImage?
    var fullName: String = ""
    var location: String = ""
    
    var rows: [Row]
    
    init() {
        rows = [
            .profilePicture,
            .textField(.name),
            .textField(.location)
        ]
    }
    
    func save() {
        
    }
    
    func modelForTextFieldRow(_ type: TextFieldType) -> ProfileTextFieldCell.Model {
        switch type {
        case .name:
            ProfileTextFieldCell.Model(
                icon: UIImage(
                    resource: .user
                ),
                placeholderText: "Your name",
                text: fullName,
                isValid: isFullNameValid()
            )
        case .location:
            ProfileTextFieldCell.Model(
                icon: UIImage(
                    resource: .location
                ),
                placeholderText: "Location",
                text: location,
                isValid: isLocationValid()
            )
        }
    }
    
    private func isFullNameValid() -> Bool {
        fullName.count > 2
    }
    
    private func isLocationValid() -> Bool {
        location.count > 2
    }
}
