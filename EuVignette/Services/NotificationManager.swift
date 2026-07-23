import Foundation
import UserNotifications

enum NotificationManager {
    static func requestAuthorization() async -> Bool {
        let center = UNUserNotificationCenter.current()
        do {
            return try await center.requestAuthorization(options: [.alert, .badge, .sound])
        } catch {
            return false
        }
    }

    static func scheduleReminder(for vignette: SavedVignette) async {
        let center = UNUserNotificationCenter.current()
        let identifier = "vignette-\(vignette.countryID)-\(vignette.licensePlate)-\(vignette.expiryDate.timeIntervalSince1970)"

        center.removePendingNotificationRequests(withIdentifiers: [identifier])

        guard vignette.reminderDaysBefore >= 0, !vignette.isExpired else { return }

        var components = Calendar.current.dateComponents([.year, .month, .day], from: vignette.expiryDate)
        components.day = (components.day ?? 0) - vignette.reminderDaysBefore
        components.hour = 9
        components.minute = 0

        guard let triggerDate = Calendar.current.date(from: components), triggerDate > Date() else { return }

        let content = UNMutableNotificationContent()
        content.title = "Vignette expiring soon"
        content.body = "\(vignette.countryFlag) \(vignette.countryName) vignette for \(vignette.licensePlate) expires on \(vignette.expiryDate.formatted(date: .abbreviated, time: .omitted))."
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate), repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        try? await center.add(request)
    }

    static func cancelReminder(for vignette: SavedVignette) {
        let identifier = "vignette-\(vignette.countryID)-\(vignette.licensePlate)-\(vignette.expiryDate.timeIntervalSince1970)"
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
