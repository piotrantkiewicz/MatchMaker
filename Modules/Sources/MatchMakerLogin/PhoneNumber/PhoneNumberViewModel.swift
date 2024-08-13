import Foundation
import MatchMakerAuth
import Swinject

public final class PhoneNumberViewModel {
    
    let coordinator: PhoneNumberCoordinator
    var container: Container
    var authService: AuthService {
        container.resolve(AuthService.self)!
    }
    
    public init(container: Container, coordinator: PhoneNumberCoordinator) {
        self.container = container
        self.coordinator = coordinator
    }
    
    public func requestOTP(with phoneNumber: String) async throws{
        try await authService.requestOTP(forPhoneNumber: phoneNumber)
        
        await MainActor.run {
            didRequestOTPSuccessfully()
        }
    }
    
    private func didRequestOTPSuccessfully() {
        coordinator.presentOTP()
    }
}
