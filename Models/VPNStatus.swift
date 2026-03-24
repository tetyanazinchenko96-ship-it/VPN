import Foundation

struct VPNStatus {
    var state: VPNConnectionState = .disconnected
    var connectedServer: VPNServer?
    var connectedDuration: TimeInterval = 0
    var ipAddress: String = "0.0.0.0"
    var downloadSpeedMbps: Double = 0
    var uploadSpeedMbps: Double = 0
    var latencyMS: Int = 0
}
