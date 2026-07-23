import SwiftUI
import UserNotifications

struct SettingsView: View {
    @State private var licensePlate = UserSettings.defaultLicensePlate
    @State private var remindersEnabled = UserSettings.remindersEnabled
    @State private var notificationStatus = "Unknown"

    var body: some View {
        NavigationStack {
            Form {
                Section("Vehicle") {
                    TextField("Default license plate", text: $licensePlate)
                        .textInputAutocapitalization(.characters)
                        .autocorrectionDisabled()
                        .onChange(of: licensePlate) { _, newValue in
                            UserSettings.defaultLicensePlate = newValue.uppercased()
                        }
                }

                Section("Notifications") {
                    Toggle("Expiry reminders", isOn: $remindersEnabled)
                        .onChange(of: remindersEnabled) { _, newValue in
                            UserSettings.remindersEnabled = newValue
                            if newValue {
                                Task {
                                    let granted = await NotificationManager.requestAuthorization()
                                    await MainActor.run {
                                        notificationStatus = granted ? "Allowed" : "Denied"
                                    }
                                }
                            }
                        }

                    LabeledContent("Permission status", value: notificationStatus)
                }

                Section("About") {
                    LabeledContent("Version", value: "1.0.0")
                    Text("EU Vignette helps you plan motorway travel in Europe, track purchased vignettes, and open official government purchase portals.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
            .task {
                let settings = await UNUserNotificationCenter.current().notificationSettings()
                notificationStatus = switch settings.authorizationStatus {
                case .authorized, .provisional, .ephemeral: "Allowed"
                case .denied: "Denied"
                case .notDetermined: "Not requested"
                @unknown default: "Unknown"
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
