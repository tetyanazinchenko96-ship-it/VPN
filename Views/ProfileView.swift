import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.md) {
                PremiumCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Account")
                            .font(Typography.title)
                        Text(viewModel.profile.isSignedIn ? (viewModel.profile.email ?? "Signed In") : "Not signed in")
                            .foregroundStyle(.secondary)
                        SecondaryButton(title: viewModel.profile.isSignedIn ? "Manage Account" : "Sign In") {}
                    }
                }

                PremiumCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Subscription Status")
                            .font(Typography.title)
                        HStack {
                            Text(viewModel.profile.subscriptionStatus)
                            StatusBadge(text: viewModel.activePlan != nil ? "Active" : "Placeholder", color: AppColors.success)
                        }
                        Text("Plan: \(viewModel.profile.currentPlanName)")
                        Text(viewModel.profile.renewalInfo)
                            .font(Typography.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Profile")
    }
}
