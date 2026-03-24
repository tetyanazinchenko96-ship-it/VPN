import Combine
import Foundation

protocol SubscriptionManaging {
    var plansPublisher: AnyPublisher<[SubscriptionPlan], Never> { get }
    var activePlanPublisher: AnyPublisher<SubscriptionPlan?, Never> { get }
    var features: [SubscriptionFeature] { get }

    func fetchPlans()
    func purchase(plan: SubscriptionPlan)
    func restorePurchases()
}
