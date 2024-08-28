import Foundation
import FirebaseDatabase
import MatchMakerAuth
import MatchMakerCore

public protocol MatchesRepository {
    func fetchMatches() async throws -> [User]
}

public class MatchesRepositoryLive: MatchesRepository {
    
    private let authService: AuthService
    private let database: DatabaseReference
    
    public init(
        authService: AuthService,
        database: DatabaseReference = Database.database().reference()
    ) {
        self.authService = authService
        self.database = database
    }
    
    public func fetchMatches() async throws -> [User] {
        guard let currentUser = authService.user else {
            throw AuthError.notAuthenticated
        }
        
        let snapshot = try await database.child("matches").child(currentUser.uid).getData()
        guard snapshot.exists() else { return [] }
        
        let matches = try snapshot.data(as: [String: Bool].self)
        
        return try await withThrowingTaskGroup(of: User?.self) { group in
            for (uid, _) in matches {
                group.addTask {
                    let profile = try await self.fetchUserProfile(uid)
                    guard let url = profile.profilePictureUrl else { return nil }
                    return User(uid: uid, name: profile.fullName, imageURL: url)
                }
            }
            
            var users = [User]()
            
            for try await user in group {
                guard let user else { continue }
                users.append(user)
            }
            
            return users
        }
    }
    
    private func fetchUserProfile(_ uid: String) async throws -> UserProfile {
        let snapshot = try await database.child("users").child(uid).getData()
        return try snapshot.data(as: UserProfile.self)
    }
}







