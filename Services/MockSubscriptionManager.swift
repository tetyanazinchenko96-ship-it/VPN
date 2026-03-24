import Combine
import Foundation

final class MockSubscriptionManager: SubscriptionManaging {
    private let plansSubject = CurrentValueSubject<[SubscriptionPlan], Never>([])
    private let activePlanSubject = CurrentValueSubject<SubscriptionPlan?, Never>(nil)

    var features: [SubscriptionFeature] = MockData.subscriptionFeatures

    var plansPublisher: AnyPublisher<[SubscriptionPlan], Never> {
        plansSubject.eraseToAnyPublisher()
    }

    var activePlanPublisher: AnyPublisher<SubscriptionPlan?, Never> {
        activePlanSubject.eraseToAnyPublisher()
    }

    func fetchPlans() {
        // StoreKit 2 integration point:
        // Replace with Product.products(for:) and map products to SubscriptionPlan.
        plansSubject.send(MockData.subscriptionPlans)
    }

    func purchase(plan: SubscriptionPlan) {
        // StoreKit 2 integration point:
        // Trigger purchase flow and validate current entitlements.
        activePlanSubject.send(plan)
    }

    func restorePurchases() {
        // StoreKit 2 integration point:
        // Use AppStore.sync() / transaction restore checks.
        if let yearly = MockData.subscriptionPlans.first(where: { $0.cycle == .yearly }) {
            activePlanSubject.send(yearly)
        }
    }
}
