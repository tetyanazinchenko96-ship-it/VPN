import SwiftUI

struct ServerListView: View {
    @ObservedObject var viewModel: ServerListViewModel

    var body: some View {
        List {
            ForEach(viewModel.groupedServers.keys.sorted(), id: \.self) { region in
                Section(regionTitle(region)) {
                    ForEach(viewModel.groupedServers[region] ?? []) { server in
                        ServerRow(server: server, isSelected: viewModel.selectedServer == server)
                            .listRowSeparator(.hidden)
                            .onTapGesture { viewModel.select(server) }
                    }
                }
            }
        }
        .listStyle(.plain)
        .searchable(text: $viewModel.searchText, prompt: "Search regions or cities")
        .navigationTitle("Locations")
    }

    private func regionTitle(_ code: String) -> String {
        switch code {
        case "NA": return "North America"
        case "EU": return "Europe"
        case "APAC": return "Asia Pacific"
        default: return code
        }
    }
}
