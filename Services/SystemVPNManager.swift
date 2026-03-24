import Combine
import Foundation

#if canImport(NetworkExtension)
import NetworkExtension
#endif

final class SystemVPNManager: VPNManaging {
    private let statusSubject = CurrentValueSubject<VPNStatus, Never>(VPNStatus())
    private(set) var availableServers: [VPNServer] = []
    private(set) var selectedServer: VPNServer?

    var statusPublisher: AnyPublisher<VPNStatus, Never> {
        statusSubject.eraseToAnyPublisher()
    }

    func connect() {
        // Real VPN integration requires:
        // 1) Apple Network Extension entitlement approval.
        // 2) A Packet Tunnel Provider extension target.
        // 3) NETunnelProviderManager configuration and saved preferences.
        // 4) Provider protocol configuration to pass server/auth data to extension.
        var status = statusSubject.value
        status.state = .error
        statusSubject.send(status)
    }

    func disconnect() {
        // Hook into NEVPNConnection stop logic when integrating real backend.
        var status = statusSubject.value
        status.state = .disconnected
        statusSubject.send(status)
    }

    func selectServer(_ server: VPNServer) {
        selectedServer = server
    }
}
