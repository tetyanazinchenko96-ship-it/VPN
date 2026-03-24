import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    @Published private(set) var status: VPNStatus = VPNStatus()

    private let vpnManager: VPNManaging
    private var cancellables = Set<AnyCancellable>()

    init(vpnManager: VPNManaging) {
        self.vpnManager = vpnManager
        vpnManager.statusPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$status)
    }

    func toggleConnection() {
        switch status.state {
        case .disconnected, .error:
            vpnManager.connect()
        case .connected:
            vpnManager.disconnect()
        case .connecting, .disconnecting:
            break
        }
    }

    var statusColor: String {
        switch status.state {
        case .connected: return "green"
        case .connecting, .disconnecting: return "orange"
        case .disconnected, .error: return "red"
        }
    }
}
