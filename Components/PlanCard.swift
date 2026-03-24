import SwiftUI

struct PlanCard: View {
    let plan: SubscriptionPlan
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(plan.name)
                    .font(Typography.title)
                Spacer()
                if plan.isBestValue {
                    StatusBadge(text: "Best Value", color: AppColors.success)
                }
            }
            Text(plan.subtitle)
                .font(Typography.caption)
                .foregroundStyle(.secondary)
            Text(plan.price)
                .font(Typography.largeTitle)
        }
        .padding(AppTheme.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(isSelected ? AppTheme.heroGradient.opacity(0.22) : Color.secondary.opacity(0.08))
        .overlay {
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.lg, style: .continuous)
                .stroke(isSelected ? AppColors.primary : Color.clear, lineWidth: 1.5)
        }
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.lg, style: .continuous))
    }
}
