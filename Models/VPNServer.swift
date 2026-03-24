import Foundation

struct VPNServer: Identifiable, Codable, Equatable {
    let id: UUID
    let regionCode: String
    let countryName: String
    let city: String
    let serverName: String
    let flag: String
    let latencyMS: Int
    let isPremiumOnly: Bool
    let isRecommended: Bool

    init(
        id: UUID = UUID(),
        regionCode: String,
        countryName: String,
        city: String,
        serverName: String,
        flag: String,
        latencyMS: Int,
        isPremiumOnly: Bool,
        isRecommended: Bool = false
    ) {
        self.id = id
        self.regionCode = regionCode
        self.countryName = countryName
        self.city = city
        self.serverName = serverName
        self.flag = flag
        self.latencyMS = latencyMS
        self.isPremiumOnly = isPremiumOnly
        self.isRecommended = isRecommended
    }

    var displayTitle: String {
        "\(countryName) • \(city)"
    }
}
