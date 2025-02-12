import SwiftUI

// Main Copy

//MARK: Auth Manager For Global Properties

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var userPhoneNumber: String = ""

    init() {
        // Load saved user data from UserDefaults
        loadUserSession()
    }

    func login(with phoneNumber: String) {
        // Store user authentication state and phone number
        UserDefaults.standard.set(true, forKey: "isAuthenticated")
        UserDefaults.standard.set(phoneNumber, forKey: "userPhoneNumber")

        // Update app state
        isAuthenticated = true
        userPhoneNumber = phoneNumber
    }

    func logout() {
        // Clear authentication data
        UserDefaults.standard.removeObject(forKey: "isAuthenticated")
        UserDefaults.standard.removeObject(forKey: "userPhoneNumber")

        isAuthenticated = false
        userPhoneNumber = ""
    }

    private func loadUserSession() {
        // Fetch user authentication status and phone number
        isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        userPhoneNumber = UserDefaults.standard.string(forKey: "userPhoneNumber") ?? ""
    }
}
