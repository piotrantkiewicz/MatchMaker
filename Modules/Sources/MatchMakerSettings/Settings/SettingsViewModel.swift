import UIKit
import MatchMakerAuth
import Swinject

public final class SettingsViewModel {
    
    struct Header {
        let imageUrl: URL?
        let name: String
        let location: String
    }
    
    var header: Header
    
    var didUpdateHeader: (() -> ())?
    
    private let authService: AuthService
    private let userProfileRepository: UserProfileRepository
    private let profilePictureRepository: ProfilePictureRepository
    
    let container: Container
    
    public init(
        container: Container
    ) {
        self.container = container
        self.authService = container.resolve(AuthService.self)!
        self.userProfileRepository = container.resolve(UserProfileRepository.self)!
        self.profilePictureRepository = container.resolve(ProfilePictureRepository.self)!
        
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
