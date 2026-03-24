import SwiftUI

enum AppTheme {
    static let heroGradient = LinearGradient(
        colors: [AppColors.primary, AppColors.accent],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    enum Spacing {
        static let xs: CGFloat = 6
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
    }

    enum CornerRadius {
        static let md: CGFloat = 14
        static let lg: CGFloat = 20
        static let xl: CGFloat = 28
    }

    enum Shadows {
        static let card = Color.black.opacity(0.12)
    }
}
