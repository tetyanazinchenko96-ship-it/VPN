import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            AppTheme.heroGradient.ignoresSafeArea()
            VStack(spacing: 12) {
                Image(systemName: "shield.lefthalf.filled")
                    .font(.system(size: 56))
                    .foregroundStyle(.white)
                Text(AppConstants.appName)
                    .font(Typography.largeTitle)
                    .foregroundStyle(.white)
                Text("Private. Fast. Premium.")
                    .foregroundStyle(.white.opacity(0.85))
            }
        }
    }
}
