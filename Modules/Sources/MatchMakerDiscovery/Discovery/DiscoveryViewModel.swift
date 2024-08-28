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
}
