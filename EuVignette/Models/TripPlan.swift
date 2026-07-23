import Foundation
import SwiftData

@Model
final class TripPlan {
    var name: String
    var startDate: Date
    var endDate: Date
    var countryIDs: [String]
    var notes: String
    var createdAt: Date

    init(
        name: String,
        startDate: Date,
        endDate: Date,
        countryIDs: [String],
        notes: String = "",
        createdAt: Date = .now
    ) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.countryIDs = countryIDs
        self.notes = notes
        self.createdAt = createdAt
    }
}
