import Foundation

enum UserSettings {
    private static let licensePlateKey = "defaultLicensePlate"
    private static let remindersEnabledKey = "remindersEnabled"

    static var defaultLicensePlate: String {
        get { UserDefaults.standard.string(forKey: licensePlateKey) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: licensePlateKey) }
    }

    static var remindersEnabled: Bool {
        get {
            if UserDefaults.standard.object(forKey: remindersEnabledKey) == nil {
                return true
            }
            return UserDefaults.standard.bool(forKey: remindersEnabledKey)
        }
        set { UserDefaults.standard.set(newValue, forKey: remindersEnabledKey) }
    }
}
