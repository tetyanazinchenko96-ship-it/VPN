import Foundation

final class ServerListViewModel: ObservableObject {
    @Published var searchText = ""
    @Published private(set) var selectedServer: VPNServer?

    private let vpnManager: VPNManaging

    init(vpnManager: VPNManaging) {
        self.vpnManager = vpnManager
        selectedServer = vpnManager.selectedServer
    }

    var groupedServers: [String: [VPNServer]] {
        let filtered = vpnManager.availableServers.filter { server in
            searchText.isEmpty || server.countryName.localizedCaseInsensitiveContains(searchText) || server.city.localizedCaseInsensitiveContains(searchText)
        }
        return Dictionary(grouping: filtered, by: { $0.regionCode })
    }

    func select(_ server: VPNServer) {
        vpnManager.selectServer(server)
        selectedServer = server
    }
}
