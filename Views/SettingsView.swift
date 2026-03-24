import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @ObservedObject var profileViewModel: ProfileViewModel

    var body: some View {
        List {
            Section("Connection") {
                SettingRow(icon: "bolt.shield.fill", title: "Auto Connect") {
                    Toggle("", isOn: Binding(get: { viewModel.userSettings.autoConnect }, set: viewModel.setAutoConnect)).labelsHidden()
                }
                SettingRow(icon: "wifi", title: "Connect on Wi-Fi") {
                    Toggle("", isOn: Binding(get: { viewModel.userSettings.connectOnWiFi }, set: viewModel.setWiFi)).labelsHidden()
                }
                SettingRow(icon: "antenna.radiowaves.left.and.right", title: "Connect on Cellular") {
                    Toggle("", isOn: Binding(get: { viewModel.userSettings.connectOnCellular }, set: viewModel.setCellular)).labelsHidden()
                }
                SettingRow(icon: "shield", title: "Protocol", subtitle: "WireGuard (placeholder)") {
                    Image(systemName: "chevron.right").foregroundStyle(.secondary)
                }
                SettingRow(icon: "lock.trianglebadge.exclamationmark", title: "Kill Switch", subtitle: "UI placeholder") {
                    StatusBadge(text: "Premium", color: AppColors.warning)
                }
            }

            Section("Appearance") {
                Picker("Theme", selection: Binding(get: { viewModel.userSettings.themeMode }, set: viewModel.setTheme)) {
                    ForEach(UserSettings.ThemeMode.allCases) { mode in
                        Text(mode.title).tag(mode)
                    }
                }
            }

            Section("Account") {
                NavigationLink {
                    ProfileView(viewModel: profileViewModel)
                } label: {
                    Text("Manage Subscription")
                }
                Text("Privacy Policy (placeholder)")
                Text("Terms of Service (placeholder)")
            }

            Section("About") {
                Text("Version \(AppConstants.appVersion)")
            }
        }
        .navigationTitle("Settings")
    }
}
