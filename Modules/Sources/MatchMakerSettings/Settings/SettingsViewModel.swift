import UIKit
import MatchMakerAuth

public final class SettingsViewModel {
    
    struct Header {
        let imageUrl: URL?
        let name: String
        let location: String
    }
    
    var header: Header
    
    var didUpdateHeader: (() -> ())?
    
    let authService: AuthService
    let userProfileRepository: UserProfileRepository
    let profilePictureRepository: ProfilePictureRepository
    
    public init(
        authService: AuthService,
        userProfileRepository: UserProfileRepository,
        profilePictureRepository: ProfilePictureRepository
    ) {
        self.authService = authService
        self.userProfileRepository = userProfileRepository
        self.profilePictureRepository = profilePictureRepository
        
        self.header = Header(
            imageUrl: nil,
            name: "Setup Your Name",
            location: "No Location"
        )
    }
    
    func logout() throws {
        try authService.logout()
        NotificationCenter.default.post(.didLogout)
    }
    
    func fetchUserProfile() {
        Task { [weak self] in
            do {
                guard let profile = try await self?.userProfileRepository.fetchUserProfile()
                else { return }
                
                await MainActor.run { [weak self] in
                    self?.updateHeader(with: profile)
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func updateHeader(with userProfile: UserProfile) {
        self.header = Header(
            imageUrl: userProfile.profilePictureUrl,
            name: userProfile.fullName,
            location: userProfile.location
        )
        
        didUpdateHeader?()
    }
}
