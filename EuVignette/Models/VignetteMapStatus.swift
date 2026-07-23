import SwiftUI

enum VignetteMapStatus: String, CaseIterable {
    case valid
    case expiringSoon
    case missing
    case notRequired

    var label: String {
        switch self {
        case .valid: "Valid vignette"
        case .expiringSoon: "Expiring within 30 days"
        case .missing: "Vignette required"
        case .notRequired: "No vignette required"
        }
    }

    var color: Color {
        switch self {
        case .valid: Color(red: 0.20, green: 0.78, blue: 0.35)
        case .expiringSoon: Color(red: 1.0, green: 0.80, blue: 0.0)
        case .missing: Color(red: 1.0, green: 0.23, blue: 0.19)
        case .notRequired: Color(red: 0.68, green: 0.68, blue: 0.70)
        }
    }
}
