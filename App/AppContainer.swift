import Foundation

final class AppContainer: ObservableObject {
    let vpnManager: VPNManaging
    let subscriptionManager: SubscriptionManaging
    let settingsManager: SettingsManaging

    let homeViewModel: HomeViewModel
    let serverListViewModel: ServerListViewModel
    let paywallViewModel: PaywallViewModel
    let settingsViewModel: SettingsViewModel
    let onboardingViewModel: OnboardingViewModel
    let profileViewModel: ProfileViewModel

    init() {
        settingsManager = DefaultSettingsManager()
        vpnManager = MockVPNManager(settingsManager: settingsManager)
        subscriptionManager = MockSubscriptionManager()

        homeViewModel = HomeViewModel(vpnManager: vpnManager)
        serverListViewModel = ServerListViewModel(vpnManager: vpnManager)
        paywallViewModel = PaywallViewModel(subscriptionManager: subscriptionManager)
        settingsViewModel = SettingsViewModel(settingsManager: settingsManager)
        onboardingViewModel = OnboardingViewModel(settingsManager: settingsManager)
        profileViewModel = ProfileViewModel(subscriptionManager: subscriptionManager)
    }
}
