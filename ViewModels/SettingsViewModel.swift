import Combine
import Foundation

final class SettingsViewModel: ObservableObject {
    @Published private(set) var userSettings: UserSettings = .default

    private let settingsManager: SettingsManaging
    private var cancellables = Set<AnyCancellable>()

    init(settingsManager: SettingsManaging) {
        self.settingsManager = settingsManager

        settingsManager.settingsPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$userSettings)
    }

    func setAutoConnect(_ value: Bool) { settingsManager.update { $0.autoConnect = value } }
    func setWiFi(_ value: Bool) { settingsManager.update { $0.connectOnWiFi = value } }
    func setCellular(_ value: Bool) { settingsManager.update { $0.connectOnCellular = value } }
    func setTheme(_ mode: UserSettings.ThemeMode) { settingsManager.update { $0.themeMode = mode } }
}
