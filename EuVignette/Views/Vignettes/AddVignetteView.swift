import SwiftUI
import SwiftData

struct AddVignetteView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var selectedCountryID = CountryCatalog.all.first?.id ?? "AT"
    @State private var licensePlate = UserSettings.defaultLicensePlate
    @State private var selectedDuration = ""
    @State private var purchaseDate = Date.now
    @State private var expiryDate = Calendar.current.date(byAdding: .day, value: 10, to: Date.now) ?? .now
    @State private var notes = ""
    @State private var reminderDaysBefore = 3

    private var selectedCountry: VignetteCountry? {
        CountryCatalog.country(id: selectedCountryID)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Country") {
                    Picker("Country", selection: $selectedCountryID) {
                        ForEach(CountryCatalog.all) { country in
                            Text("\(country.flag) \(country.name)").tag(country.id)
                        }
                    }
                    .onChange(of: selectedCountryID) { _, _ in
                        selectedDuration = selectedCountry?.options.first?.label ?? ""
                    }
                }

                Section("Vehicle") {
                    TextField("License plate", text: $licensePlate)
                        .textInputAutocapitalization(.characters)
                        .autocorrectionDisabled()
                }

                if let country = selectedCountry {
                    Section("Duration") {
                        Picker("Duration", selection: $selectedDuration) {
                            ForEach(country.options) { option in
                                Text("\(option.label) — \(option.price)").tag(option.label)
                            }
                        }
                        .onAppear {
                            if selectedDuration.isEmpty {
                                selectedDuration = country.options.first?.label ?? ""
                            }
                        }
                    }
                }

                Section("Dates") {
                    DatePicker("Purchase date", selection: $purchaseDate, displayedComponents: .date)
                    DatePicker("Expiry date", selection: $expiryDate, displayedComponents: .date)
                }

                Section("Reminder") {
                    Stepper("Remind \(reminderDaysBefore) day(s) before expiry", value: $reminderDaysBefore, in: 0...14)
                }

                Section("Notes") {
                    TextField("Optional notes", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Add Vignette")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveVignette() }
                        .disabled(licensePlate.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || selectedCountry == nil)
                }
            }
        }
    }

    private func saveVignette() {
        guard let country = selectedCountry else { return }
        let plate = licensePlate.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        let vignette = SavedVignette(
            countryID: country.id,
            countryName: country.name,
            countryFlag: country.flag,
            licensePlate: plate,
            durationLabel: selectedDuration,
            purchaseDate: purchaseDate,
            expiryDate: expiryDate,
            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines),
            reminderDaysBefore: reminderDaysBefore
        )

        modelContext.insert(vignette)

        if UserSettings.remindersEnabled {
            Task {
                _ = await NotificationManager.requestAuthorization()
                await NotificationManager.scheduleReminder(for: vignette)
            }
        }

        dismiss()
    }
}

#Preview {
    AddVignetteView()
        .modelContainer(for: SavedVignette.self, inMemory: true)
}
