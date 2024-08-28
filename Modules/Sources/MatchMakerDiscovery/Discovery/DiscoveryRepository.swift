import Foundation
import FirebaseDatabase
import MatchMakerAuth
import MatchMakerCore

public protocol DiscoveryRepository {
    func fetchPotentialMatches() async throws -> [User]
    func swipe(with direction: SwipeDirection, on user: User) async throws
}

public class DiscoveryRepositoryLive: DiscoveryRepository {
    
    private let authService: AuthService
    private let database: DatabaseReference
    
    public init(
        authService: AuthService,
        database: DatabaseReference = Database.database().reference()
    ) {
        self.authService = authService
        self.database = database
    }
    
    public func fetchPotentialMatches() async throws -> [User] {
        guard let currentUser = authService.user else {
            throw AuthError.notAuthenticated
        }
        
        let allUsers = try await fetchUsers()
        
        let swipes = await fetchSwipes(for: currentUser.uid)
        
        return allUsers.compactMap { uid, user in
            if uid == currentUser.uid {
                return nil
            }
            
            if swipes[uid] != nil {
                return nil
            }
            
            guard let url = user.profilePictureUrl else { return nil }
            
            return User(uid: uid, name: user.fullName, imageURL: url)
        }
    }
    
    private func fetchUsers() async throws -> [String: UserProfile] {
        let snapshot = try await database.child("users").getData()
        guard snapshot.exists() else { return [:] }
        
        return try snapshot.data(as: [String: UserProfile].self)
    }
    
    private func fetchSwipes(for uid: String) async -> [String: Bool]{
        let swipesSnapshot = try? await database.child("swipes").child(uid).getData()
        guard let swipes = (try? swipesSnapshot?.data(as: [String: Bool].self)) else {
            return [:]
        }
        return swipes
    }
    
    public func swipe(with direction: SwipeDirection, on user: User) async throws {
        guard let currentUser = authService.user else {
            throw AuthError.notAuthenticated
        }
        
        try await database.child("swipes").child(currentUser.uid).child(user.uid).setValue(
            direction == .right
        )
        
        guard direction == .right else { return }
        let otherUserSwipedRight = try await swipe(for: user.uid, on: currentUser.uid)
        
        guard otherUserSwipedRight else { return }
        
        try await database.child("matches").child(currentUser.uid).child(user.uid).setValue(true)
        try await database.child("matches").child(user.uid).child(currentUser.uid).setValue(true)
    }
    
    private func swipe(for user: String, on anotherUser: String) async throws -> Bool {
        try await database.child("swipes").child(user).child(anotherUser)
            .getData()
            .value as? Bool ?? false
    }
}






