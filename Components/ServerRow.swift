import SwiftUI

struct ServerRow: View {
    let server: VPNServer
    let isSelected: Bool

    var body: some View {
        HStack(spacing: AppTheme.Spacing.sm) {
            Text(server.flag)
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(server.displayTitle)
                        .font(Typography.headline)
                    if server.isRecommended {
                        StatusBadge(text: "Fastest", color: AppColors.success)
                    }
                    if server.isPremiumOnly {
                        StatusBadge(text: "Premium", color: AppColors.warning)
                    }
                }
                Text("\(server.serverName) • \(server.latencyMS) ms")
                    .font(Typography.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(AppColors.success)
            }
        }
        .padding(AppTheme.Spacing.sm)
        .background(isSelected ? AppColors.primary.opacity(0.12) : Color.secondary.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.md, style: .continuous))
    }
}
