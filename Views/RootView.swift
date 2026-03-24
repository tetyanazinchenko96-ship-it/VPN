import SwiftUI

struct RootView: View {
    @EnvironmentObject private var container: AppContainer
    @StateObject private var rootViewModel = RootViewModel()

    var body: some View {
        Group {
            if rootViewModel.showSplash {
                SplashView()
            } else if !container.onboardingViewModel.completed {
                OnboardingView(viewModel: container.onboardingViewModel)
            } else {
                MainTabView()
                    .environmentObject(container)
            }
        }
        .onAppear(perform: rootViewModel.completeSplash)
    }
}
