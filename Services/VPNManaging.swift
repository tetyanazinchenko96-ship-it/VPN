import Combine
import Foundation

protocol VPNManaging {
    var statusPublisher: AnyPublisher<VPNStatus, Never> { get }
    var availableServers: [VPNServer] { get }
    var selectedServer: VPNServer? { get }

    func connect()
    func disconnect()
    func selectServer(_ server: VPNServer)
}
