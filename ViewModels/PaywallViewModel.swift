import Combine
import Foundation

final class PaywallViewModel: ObservableObject {
    @Published var plans: [SubscriptionPlan] = []
    @Published var selectedPlan: SubscriptionPlan?
    @Published var activePlan: SubscriptionPlan?

    let features: [SubscriptionFeature]

    private let subscriptionManager: SubscriptionManaging
    private var cancellables = Set<AnyCancellable>()

    init(subscriptionManager: SubscriptionManaging) {
        self.subscriptionManager = subscriptionManager
        self.features = subscriptionManager.features

        subscriptionManager.plansPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] plans in
                self?.plans = plans
                if self?.selectedPlan == nil {
                    self?.selectedPlan = plans.first(where: { $0.isBestValue }) ?? plans.first
                }
            }
            .store(in: &cancellables)

        subscriptionManager.activePlanPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$activePlan)

        subscriptionManager.fetchPlans()
    }

    func purchaseSelected() {
        guard let selectedPlan else { return }
        subscriptionManager.purchase(plan: selectedPlan)
    }

    func restorePurchases() {
        subscriptionManager.restorePurchases()
    }
}
