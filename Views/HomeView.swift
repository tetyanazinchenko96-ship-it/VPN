import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var pulse = false

    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.md) {
                PremiumCard {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: iconName)
                                .foregroundStyle(statusColor)
                                .font(.title2)
                                .contentTransition(.symbolEffect(.replace))
                            Text(viewModel.status.state.title)
                                .font(Typography.title)
                            Spacer()
                            StatusBadge(text: viewModel.status.connectedServer?.countryName ?? "No Server", color: .blue)
                        }

                        Text("Session: \(TimeFormatter.clockString(from: viewModel.status.connectedDuration))")
                            .foregroundStyle(.secondary)

                        HStack(spacing: 10) {
                            MetricTile(title: "IP Address", value: viewModel.status.ipAddress)
                            MetricTile(title: "Latency", value: "\(viewModel.status.latencyMS) ms")
                        }

                        HStack(spacing: 10) {
                            MetricTile(title: "Download", value: String(format: "%.0f Mbps", viewModel.status.downloadSpeedMbps))
                            MetricTile(title: "Upload", value: String(format: "%.0f Mbps", viewModel.status.uploadSpeedMbps))
                        }
                    }
                }

                Button(action: viewModel.toggleConnection) {
                    ZStack {
                        Circle()
                            .fill(AppTheme.heroGradient)
                            .frame(width: 180, height: 180)
                        Circle()
                            .stroke(.white.opacity(0.4), lineWidth: 2)
                            .frame(width: 170, height: 170)
                        Text(buttonTitle)
                            .font(Typography.title)
                            .foregroundStyle(.white)
                    }
                    .scaleEffect(viewModel.status.state == .connecting && pulse ? 1.06 : 1)
                    .shadow(color: AppColors.primary.opacity(0.5), radius: pulse ? 24 : 8)
                }
                .buttonStyle(.plain)
                .disabled(viewModel.status.state == .connecting || viewModel.status.state == .disconnecting)
            }
            .padding()
        }
        .navigationTitle("LumaVPN")
        .animation(.easeInOut(duration: 0.35), value: viewModel.status.state)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                pulse = true
            }
        }
    }

    private var buttonTitle: String {
        viewModel.status.state == .connected ? "Disconnect" : "Connect"
    }

    private var iconName: String {
        switch viewModel.status.state {
        case .connected: return "checkmark.shield.fill"
        case .connecting, .disconnecting: return "arrow.triangle.2.circlepath.shield"
        case .disconnected, .error: return "xmark.shield.fill"
        }
    }

    private var statusColor: Color {
        switch viewModel.status.state {
        case .connected: return AppColors.success
        case .connecting, .disconnecting: return AppColors.warning
        case .disconnected, .error: return AppColors.danger
        }
    }
}
