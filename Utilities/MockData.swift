import Foundation

enum MockData {
    static let servers: [VPNServer] = [
        VPNServer(regionCode: "NA", countryName: "United States", city: "New York", serverName: "Empire-01", flag: "🇺🇸", latencyMS: 24, isPremiumOnly: false, isRecommended: true),
        VPNServer(regionCode: "NA", countryName: "Canada", city: "Toronto", serverName: "Maple-03", flag: "🇨🇦", latencyMS: 38, isPremiumOnly: false),
        VPNServer(regionCode: "EU", countryName: "United Kingdom", city: "London", serverName: "Thames-02", flag: "🇬🇧", latencyMS: 79, isPremiumOnly: true),
        VPNServer(regionCode: "EU", countryName: "Germany", city: "Frankfurt", serverName: "Rhine-05", flag: "🇩🇪", latencyMS: 71, isPremiumOnly: true),
        VPNServer(regionCode: "APAC", countryName: "Japan", city: "Tokyo", serverName: "Sakura-01", flag: "🇯🇵", latencyMS: 132, isPremiumOnly: true),
        VPNServer(regionCode: "APAC", countryName: "Singapore", city: "Singapore", serverName: "Merlion-04", flag: "🇸🇬", latencyMS: 118, isPremiumOnly: true)
    ]

    static let subscriptionPlans: [SubscriptionPlan] = [
        SubscriptionPlan(id: "lumavpn.monthly", name: "Monthly", price: "$9.99", cycle: .monthly, subtitle: "Flexible monthly billing", isBestValue: false),
        SubscriptionPlan(id: "lumavpn.yearly", name: "Yearly", price: "$59.99", cycle: .yearly, subtitle: "Only $4.99/month", isBestValue: true),
        SubscriptionPlan(id: "lumavpn.lifetime", name: "Lifetime", price: "$129.99", cycle: .lifetime, subtitle: "One-time purchase", isBestValue: false)
    ]

    static let subscriptionFeatures: [SubscriptionFeature] = [
        SubscriptionFeature(title: "Unlimited Bandwidth", description: "Stream and browse with no monthly cap.", iconName: "speedometer"),
        SubscriptionFeature(title: "Global Premium Network", description: "Access high-speed regions across the globe.", iconName: "globe.americas.fill"),
        SubscriptionFeature(title: "Private DNS Shield", description: "Extra protection for your DNS queries.", iconName: "lock.shield.fill")
    ]
}
