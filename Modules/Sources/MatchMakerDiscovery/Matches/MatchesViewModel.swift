import Foundation
import Swinject

class MatchesViewModel {
    private let repository: MatchesRepository
    var matches: [User] = []
    
    init(container: Container) {
        repository = container.resolve(MatchesRepository.self)!
    }
    
    func fetchMatches() async throws {
        matches = try await repository.fetchMatches()
    }
}
