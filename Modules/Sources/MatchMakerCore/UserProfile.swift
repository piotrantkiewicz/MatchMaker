import Foundation

public struct UserProfile: Codable {
    public let fullName: String
    public let location: String
    public let profilePictureUrl: URL?
    
    public init(
        fullName: String,
        location: String,
        profilePictureUrl: URL? = nil
    ) {
        self.fullName = fullName
        self.location = location
        self.profilePictureUrl = profilePictureUrl
    }
}
