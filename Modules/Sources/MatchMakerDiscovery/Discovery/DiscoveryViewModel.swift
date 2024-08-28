import Foundation
import Swinject

public class DiscoveryViewModel {
    
    private let repository: DiscoveryRepository
    var potentialMatches: [User] = []
    
    init(container: Container) {
        repository = container.resolve(DiscoveryRepository.self)!
    }
    
    func fetchPotentialMatches() async throws {
        potentialMatches = try await repository.fetchPotentialMatches()
    }
    
    func didSwipe(_ direction: SwipeDirection, on user: User) async {
        do {
            try await repository.swipe(with: direction, on: user)
        } catch {
            print(error.localizedDescription)
        }
    }
}











