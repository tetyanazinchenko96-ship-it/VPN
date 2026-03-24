import SwiftUI

@main
struct LumaVPNApp: App {
    @StateObject private var appContainer = AppContainer()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appContainer)
                .preferredColorScheme(appContainer.settingsViewModel.userSettings.themeMode.colorScheme)
        }
    }
}
