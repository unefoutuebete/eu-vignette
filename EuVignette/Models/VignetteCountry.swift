import Foundation

struct VignetteOption: Identifiable, Hashable {
    let id: String
    let label: String
    let price: String
    let notes: String?
}

struct VignetteCountry: Identifiable, Hashable {
    let id: String
    let name: String
    let flag: String
    let summary: String
    let officialShopURL: URL
    let validityCheckURL: URL?
    let options: [VignetteOption]
    let tips: [String]
}
