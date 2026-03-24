import Foundation

struct VPNRegion: Identifiable {
    let id = UUID()
    let code: String
    let title: String
    let servers: [VPNServer]
}
