import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    private let pages: [(title: String, subtitle: String, icon: String)] = [
        ("Private by Design", "Protect your browsing with encrypted tunnels and trusted privacy architecture.", "lock.shield.fill"),
        ("Built for Speed", "Optimized global nodes keep your connection smooth for everyday streaming and work.", "bolt.horizontal.circle.fill"),
        ("Global Access", "Choose premium locations worldwide for secure remote access wherever you go.", "globe.europe.africa.fill")
    ]

    var body: some View {
        VStack(spacing: AppTheme.Spacing.lg) {
            TabView(selection: $viewModel.currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    let page = pages[index]
                    PremiumCard {
                        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                            Image(systemName: page.icon)
                                .font(.system(size: 42))
                                .foregroundStyle(AppTheme.heroGradient)
                            Text(page.title).font(Typography.title)
                            Text(page.subtitle).font(Typography.body).foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(.horizontal)
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))

            if viewModel.currentPage == pages.count - 1 {
                PrimaryButton(title: "Continue") {
                    viewModel.completeOnboarding()
                }
                .padding(.horizontal)
            } else {
                SecondaryButton(title: "Next") {
                    withAnimation { viewModel.currentPage += 1 }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, AppTheme.Spacing.xl)
    }
}
