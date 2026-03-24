import Combine
import Foundation

final class DefaultSettingsManager: SettingsManaging {
    private enum Keys {
        static let onboardingCompleted = "onboarding_completed"
        static let selectedServerID = "selected_server_id"
        static let themeMode = "theme_mode"
        static let autoConnect = "auto_connect"
        static let connectOnWiFi = "connect_on_wifi"
        static let connectOnCellular = "connect_on_cellular"
    }

    private let defaults = UserDefaults.standard
    private let subject: CurrentValueSubject<UserSettings, Never>

    var settingsPublisher: AnyPublisher<UserSettings, Never> {
        subject.eraseToAnyPublisher()
    }

    var currentSettings: UserSettings {
        subject.value
    }

    init() {
        let settings = UserSettings(
            onboardingCompleted: defaults.bool(forKey: Keys.onboardingCompleted),
            selectedServerID: UUID(uuidString: defaults.string(forKey: Keys.selectedServerID) ?? ""),
            themeMode: UserSettings.ThemeMode(rawValue: defaults.string(forKey: Keys.themeMode) ?? "") ?? .system,
            autoConnect: defaults.object(forKey: Keys.autoConnect) as? Bool ?? UserSettings.default.autoConnect,
            connectOnWiFi: defaults.object(forKey: Keys.connectOnWiFi) as? Bool ?? UserSettings.default.connectOnWiFi,
            connectOnCellular: defaults.object(forKey: Keys.connectOnCellular) as? Bool ?? UserSettings.default.connectOnCellular
        )
        subject = CurrentValueSubject(settings)
    }

    func update(_ mutation: (inout UserSettings) -> Void) {
        var settings = subject.value
        mutation(&settings)
        persist(settings)
        subject.send(settings)
    }

    private func persist(_ settings: UserSettings) {
        defaults.set(settings.onboardingCompleted, forKey: Keys.onboardingCompleted)
        defaults.set(settings.selectedServerID?.uuidString, forKey: Keys.selectedServerID)
        defaults.set(settings.themeMode.rawValue, forKey: Keys.themeMode)
        defaults.set(settings.autoConnect, forKey: Keys.autoConnect)
        defaults.set(settings.connectOnWiFi, forKey: Keys.connectOnWiFi)
        defaults.set(settings.connectOnCellular, forKey: Keys.connectOnCellular)
    }
}
