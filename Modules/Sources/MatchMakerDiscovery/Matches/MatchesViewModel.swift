import Foundation
import Swinject

class MatchesViewModel {
    var matches: [User] = []
    
    init(container: Container) {}
    
    func fetchMatches() async throws {
        matches = mockUsers
    }
}
