import Combine
import Foundation

protocol SettingsManaging {
    var settingsPublisher: AnyPublisher<UserSettings, Never> { get }
    var currentSettings: UserSettings { get }

    func update(_ mutation: (inout UserSettings) -> Void)
}
