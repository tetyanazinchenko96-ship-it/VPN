import SwiftUI

struct PaywallView: View {
    @ObservedObject var viewModel: PaywallViewModel
    @State private var animateIn = false

    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.md) {
                PremiumCard {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Upgrade to LumaVPN Premium")
                            .font(Typography.largeTitle)
                        Text("Unlock global premium servers, faster speeds, and advanced privacy tools.")
                            .foregroundStyle(.secondary)
                    }
                }

                VStack(spacing: 10) {
                    ForEach(viewModel.plans) { plan in
                        PlanCard(plan: plan, isSelected: viewModel.selectedPlan?.id == plan.id)
                            .onTapGesture { viewModel.selectedPlan = plan }
                    }
                }

                PremiumCard {
                    VStack(alignment: .leading, spacing: 8) {
                        SectionHeader(title: "Premium Features")
                        ForEach(viewModel.features) { feature in
                            Label {
                                Text(feature.title)
                            } icon: {
                                Image(systemName: feature.iconName)
                                    .foregroundStyle(AppColors.primary)
                            }
                            Text(feature.description)
                                .font(Typography.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                PrimaryButton(title: "Continue") { viewModel.purchaseSelected() }
                SecondaryButton(title: "Restore Purchases") { viewModel.restorePurchases() }

                Text("By continuing, you agree to Terms and Privacy Policy. Placeholder legal links.")
                    .font(Typography.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .offset(y: animateIn ? 0 : 24)
            .opacity(animateIn ? 1 : 0)
            .onAppear {
                withAnimation(.easeOut(duration: 0.45)) {
                    animateIn = true
                }
            }
        }
        .navigationTitle("Premium")
    }
}
