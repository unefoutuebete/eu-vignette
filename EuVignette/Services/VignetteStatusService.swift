import Foundation

enum VignetteStatusService {
    private static let calendar = Calendar.current
    private static let expiringWindowDays = 30

    static func status(for countryID: String, on date: Date, vignettes: [SavedVignette]) -> VignetteMapStatus {
        guard EuropeBoundaries.vignetteCountryIDs.contains(countryID) else {
            return .notRequired
        }

        let day = calendar.startOfDay(for: date)
        let validVignettes = vignettes.filter { vignette in
            vignette.countryID == countryID && isVignette(vignette, validOn: day)
        }

        guard let bestMatch = validVignettes.max(by: { $0.expiryDate < $1.expiryDate }) else {
            return .missing
        }

        let expiryDay = calendar.startOfDay(for: bestMatch.expiryDate)
        let daysUntilExpiry = calendar.dateComponents([.day], from: day, to: expiryDay).day ?? 0

        if daysUntilExpiry <= expiringWindowDays {
            return .expiringSoon
        }

        return .valid
    }

    static func statusSummary(for countryID: String, on date: Date, vignettes: [SavedVignette]) -> String {
        switch status(for: countryID, on: date, vignettes: vignettes) {
        case .valid:
            if let vignette = activeVignette(for: countryID, on: date, vignettes: vignettes) {
                return "Valid until \(vignette.expiryDate.formatted(date: .abbreviated, time: .omitted))"
            }
            return "Valid vignette"
        case .expiringSoon:
            if let vignette = activeVignette(for: countryID, on: date, vignettes: vignettes) {
                let days = calendar.dateComponents([.day], from: calendar.startOfDay(for: date), to: calendar.startOfDay(for: vignette.expiryDate)).day ?? 0
                return "Expires in \(days) day(s)"
            }
            return "Expiring within 30 days"
        case .missing:
            return "No valid vignette — purchase required"
        case .notRequired:
            return "No motorway vignette required"
        }
    }

    static func activeVignette(for countryID: String, on date: Date, vignettes: [SavedVignette]) -> SavedVignette? {
        let day = calendar.startOfDay(for: date)
        return vignettes
            .filter { $0.countryID == countryID && isVignette($0, validOn: day) }
            .max(by: { $0.expiryDate < $1.expiryDate })
    }

    private static func isVignette(_ vignette: SavedVignette, validOn day: Date) -> Bool {
        let purchaseDay = calendar.startOfDay(for: vignette.purchaseDate)
        let expiryDay = calendar.startOfDay(for: vignette.expiryDate)
        return purchaseDay <= day && day <= expiryDay
    }
}

extension SavedVignette {
    func isValid(on date: Date) -> Bool {
        let calendar = Calendar.current
        let day = calendar.startOfDay(for: date)
        let purchaseDay = calendar.startOfDay(for: purchaseDate)
        let expiryDay = calendar.startOfDay(for: expiryDate)
        return purchaseDay <= day && day <= expiryDay
    }
}
