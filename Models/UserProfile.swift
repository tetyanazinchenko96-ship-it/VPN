import Foundation

struct UserProfile {
    var isSignedIn: Bool
    var email: String?
    var subscriptionStatus: String
    var currentPlanName: String
    var renewalInfo: String

    static let placeholder = UserProfile(
        isSignedIn: false,
        email: nil,
        subscriptionStatus: "Premium Active",
        currentPlanName: "LumaVPN Yearly",
        renewalInfo: "Renews on April 20, 2026"
    )
}
