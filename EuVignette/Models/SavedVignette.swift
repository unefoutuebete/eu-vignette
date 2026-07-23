import Foundation
import SwiftData

@Model
final class SavedVignette {
    var countryID: String
    var countryName: String
    var countryFlag: String
    var licensePlate: String
    var durationLabel: String
    var purchaseDate: Date
    var expiryDate: Date
    var notes: String
    var reminderDaysBefore: Int

    init(
        countryID: String,
        countryName: String,
        countryFlag: String,
        licensePlate: String,
        durationLabel: String,
        purchaseDate: Date,
        expiryDate: Date,
        notes: String = "",
        reminderDaysBefore: Int = 3
    ) {
        self.countryID = countryID
        self.countryName = countryName
        self.countryFlag = countryFlag
        self.licensePlate = licensePlate
        self.durationLabel = durationLabel
        self.purchaseDate = purchaseDate
        self.expiryDate = expiryDate
        self.notes = notes
        self.reminderDaysBefore = reminderDaysBefore
    }

    var isExpired: Bool {
        expiryDate < Calendar.current.startOfDay(for: Date())
    }

    var daysRemaining: Int {
        Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: Date()), to: expiryDate).day ?? 0
    }

    var statusLabel: String {
        if isExpired {
            return "Expired"
        }
        if daysRemaining == 0 {
            return "Expires today"
        }
        if daysRemaining == 1 {
            return "1 day left"
        }
        return "\(daysRemaining) days left"
    }
}
