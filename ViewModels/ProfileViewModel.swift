import Combine
import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var profile = UserProfile.placeholder
    @Published var activePlan: SubscriptionPlan?

    private var cancellables = Set<AnyCancellable>()

    init(subscriptionManager: SubscriptionManaging) {
        subscriptionManager.activePlanPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] plan in
                self?.activePlan = plan
                if let plan {
                    self?.profile.currentPlanName = plan.name
                    self?.profile.subscriptionStatus = "Premium Active"
                }
            }
            .store(in: &cancellables)
    }
}
