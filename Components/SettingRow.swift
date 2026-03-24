import SwiftUI

struct SettingRow<Accessory: View>: View {
    let icon: String
    let title: String
    let subtitle: String?
    let accessory: Accessory

    init(icon: String, title: String, subtitle: String? = nil, @ViewBuilder accessory: () -> Accessory) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.accessory = accessory()
    }

    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 28)
                .foregroundStyle(AppColors.primary)
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                if let subtitle {
                    Text(subtitle).font(Typography.caption).foregroundStyle(.secondary)
                }
            }
            Spacer()
            accessory
        }
        .padding(.vertical, 8)
    }
}
