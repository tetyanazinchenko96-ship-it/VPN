import Combine
import Foundation

final class MockVPNManager: VPNManaging {
    private let statusSubject = CurrentValueSubject<VPNStatus, Never>(VPNStatus())
    private let settingsManager: SettingsManaging
    private var timerCancellable: AnyCancellable?

    private(set) var availableServers: [VPNServer] = MockData.servers
    private(set) var selectedServer: VPNServer?

    var statusPublisher: AnyPublisher<VPNStatus, Never> {
        statusSubject.eraseToAnyPublisher()
    }

    init(settingsManager: SettingsManaging) {
        self.settingsManager = settingsManager
        if let selectedID = settingsManager.currentSettings.selectedServerID {
            selectedServer = availableServers.first(where: { $0.id == selectedID })
        }
        if selectedServer == nil {
            selectedServer = availableServers.first(where: { $0.isRecommended }) ?? availableServers.first
        }
    }

    func connect() {
        guard let selectedServer else { return }
        transition(to: .connecting)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) { [weak self] in
            guard let self else { return }
            var status = self.statusSubject.value
            status.state = .connected
            status.connectedServer = selectedServer
            status.connectedDuration = 0
            status.ipAddress = "185.\(Int.random(in: 20...220)).\(Int.random(in: 2...250)).\(Int.random(in: 2...250))"
            status.latencyMS = selectedServer.latencyMS
            status.downloadSpeedMbps = Double.random(in: 120...320)
            status.uploadSpeedMbps = Double.random(in: 40...170)
            self.statusSubject.send(status)
            self.startTimer()
        }
    }

    func disconnect() {
        transition(to: .disconnecting)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.stopTimerAndReset()
        }
    }

    func selectServer(_ server: VPNServer) {
        selectedServer = server
        settingsManager.update { $0.selectedServerID = server.id }

        if statusSubject.value.state == .connected {
            // Simulated handoff behavior for mock flow.
            disconnect()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) { [weak self] in
                self?.connect()
            }
        }
    }

    private func transition(to state: VPNConnectionState) {
        var status = statusSubject.value
        status.state = state
        statusSubject.send(status)
    }

    private func startTimer() {
        timerCancellable?.cancel()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                var status = self.statusSubject.value
                guard status.state == .connected else { return }
                status.connectedDuration += 1
                status.downloadSpeedMbps = max(10, status.downloadSpeedMbps + Double.random(in: -8...8))
                status.uploadSpeedMbps = max(5, status.uploadSpeedMbps + Double.random(in: -5...5))
                self.statusSubject.send(status)
            }
    }

    private func stopTimerAndReset() {
        timerCancellable?.cancel()
        var status = statusSubject.value
        status = VPNStatus(state: .disconnected, connectedServer: nil, connectedDuration: 0, ipAddress: "0.0.0.0", downloadSpeedMbps: 0, uploadSpeedMbps: 0, latencyMS: 0)
        statusSubject.send(status)
    }
}
