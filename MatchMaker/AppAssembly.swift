import Foundation
import MatchMakerAuth
import MatchMakerDiscovery
import MatchMakerLogin
import MatchMakerSettings
import Swinject

class AppAssembly {
    
    let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func asemble() {
        let authService = AuthServiceLive()
        let userRepository = UserProfileRepositoryLive(authService: authService)
        let profilePictureRepository = ProfilePictureRepositoryLive(
            authService: authService,
            userProfileRepository: userRepository
        )
        
        container.register(AuthService.self) { container in
            authService
        }
        
        container.register(UserProfileRepository.self) { container in
            userRepository
        }
        
        container.register(ProfilePictureRepository.self) { container in
            profilePictureRepository
        }
        
        container.register(DiscoveryRepository.self) { _ in
            DiscoveryRepositoryLive(authService: authService)
        }
        
        container.register(MatchesRepository.self) { _ in
            MatchesRepositoryLive(authService: authService)
        }
    }
}











