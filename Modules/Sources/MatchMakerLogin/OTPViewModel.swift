import UIKit
import MatchMakerAuth

enum OTPViewModelError: Error {
    case otpNotValid
}


public final class OTPViewModel {
    
    private var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func verifyOTP(with digits: [String]) async throws {
        
        guard validate(digits: digits) else {
            throw OTPViewModelError.otpNotValid
        }
        let otp = combineToOTP(digits: digits)
        
        let user = try await authService.authenticate(with: otp)
        print(user.uid)
    }
    
    private func validate(digits: [String]) -> Bool {
        for digit in digits {
            guard digit.isValidDigit else { return false }
        }
        
        return true
    }
    
    private func combineToOTP(digits: [String]) -> String {
        digits.joined()
    }
}

fileprivate extension String {
    var isValidDigit: Bool {
        guard count == 1 else { return false }
        guard isNumber else { return false }
        return true
    }
}

extension String {
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}
