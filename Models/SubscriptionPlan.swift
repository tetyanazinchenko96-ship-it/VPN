import Foundation

struct SubscriptionPlan: Identifiable {
    enum BillingCycle: String {
        case monthly
        case yearly
        case lifetime
    }

    let id: String
    let name: String
    let price: String
    let cycle: BillingCycle
    let subtitle: String
    let isBestValue: Bool
}
