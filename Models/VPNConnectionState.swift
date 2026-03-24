import Foundation

enum VPNConnectionState: String, Codable {
    case disconnected
    case connecting
    case connected
    case disconnecting
    case error

    var title: String {
        switch self {
        case .disconnected: return "Disconnected"
        case .connecting: return "Connecting..."
        case .connected: return "Connected"
        case .disconnecting: return "Disconnecting..."
        case .error: return "Connection Error"
        }
    }
}
