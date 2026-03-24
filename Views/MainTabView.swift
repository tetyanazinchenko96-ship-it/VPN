import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var container: AppContainer

    var body: some View {
        TabView {
            NavigationStack {
                HomeView(viewModel: container.homeViewModel)
            }
            .tabItem { Label("Home", systemImage: "house.fill") }

            NavigationStack {
                ServerListView(viewModel: container.serverListViewModel)
            }
            .tabItem { Label("Locations", systemImage: "location.fill") }

            NavigationStack {
                PaywallView(viewModel: container.paywallViewModel)
            }
            .tabItem { Label("Premium", systemImage: "crown.fill") }

            NavigationStack {
                SettingsView(viewModel: container.settingsViewModel, profileViewModel: container.profileViewModel)
            }
            .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
    }
}
