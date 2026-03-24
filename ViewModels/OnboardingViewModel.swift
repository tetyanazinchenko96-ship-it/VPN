import Combine
import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var currentPage = 0
    @Published private(set) var completed = false

    private let settingsManager: SettingsManaging

    init(settingsManager: SettingsManaging) {
        self.settingsManager = settingsManager
        completed = settingsManager.currentSettings.onboardingCompleted
    }

    func completeOnboarding() {
        settingsManager.update { $0.onboardingCompleted = true }
        completed = true
    }
}
