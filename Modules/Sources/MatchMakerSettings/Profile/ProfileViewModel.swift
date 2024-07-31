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
    var profilePictureUrl: URL?
    
    var rows: [Row]
    
    private let userProfileRepository: UserProfileRepository
    private let profilePictureRepository: ProfilePictureRepository
    
    init(
        userProfileRepository: UserProfileRepository,
        profilePictureRepository: ProfilePictureRepository
    ) {
        
        self.userProfileRepository = userProfileRepository
        self.profilePictureRepository = profilePictureRepository
        
        if let profile = userProfileRepository.profile {
            fullName = profile.fullName
            location = profile.location
            profilePictureUrl = profile.profilePictureUrl
        }
        
        rows = [
            .profilePicture,
            .textField(.name),
            .textField(.location)
        ]
    }
    
    func save() async throws {
        let profile = UserProfile(fullName: fullName, location: location, profilePictureUr: nil)
        try userProfileRepository.saveUserProfile(profile)
        
        guard let selectedImage else { return }
        
        try await profilePictureRepository.upload(selectedImage)
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
