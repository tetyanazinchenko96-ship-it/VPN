import Foundation
import SwiftUI

struct UserSettings: Codable {
    enum ThemeMode: String, Codable, CaseIterable, Identifiable {
        case system
        case light
        case dark

        var id: String { rawValue }

        var title: String {
            switch self {
            case .system: return "System"
            case .light: return "Light"
            case .dark: return "Dark"
            }
        }

        var colorScheme: ColorScheme? {
            switch self {
            case .system: return nil
            case .light: return .light
            case .dark: return .dark
            }
        }
    }

    var onboardingCompleted: Bool
    var selectedServerID: UUID?
    var themeMode: ThemeMode
    var autoConnect: Bool
    var connectOnWiFi: Bool
    var connectOnCellular: Bool

    static let `default` = UserSettings(
        onboardingCompleted: false,
        selectedServerID: nil,
        themeMode: .system,
        autoConnect: false,
        connectOnWiFi: true,
        connectOnCellular: false
    )
}
