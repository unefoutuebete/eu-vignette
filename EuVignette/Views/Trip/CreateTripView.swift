import SwiftUI
import SwiftData

struct CreateTripView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var name = ""
    @State private var startDate = Date.now
    @State private var endDate = Calendar.current.date(byAdding: .day, value: 7, to: Date.now) ?? .now
    @State private var selectedCountryIDs: Set<String> = []
    @State private var notes = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Trip details") {
                    TextField("Trip name", text: $name)
                    DatePicker("Start", selection: $startDate, displayedComponents: .date)
                    DatePicker("End", selection: $endDate, displayedComponents: .date)
                }

                Section("Countries on route") {
                    ForEach(CountryCatalog.all) { country in
                        Toggle(isOn: binding(for: country.id)) {
                            Text("\(country.flag) \(country.name)")
                        }
                    }
                }

                Section("Notes") {
                    TextField("Optional notes", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("New Trip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveTrip() }
                        .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || selectedCountryIDs.isEmpty)
                }
            }
        }
    }

    private func binding(for countryID: String) -> Binding<Bool> {
        Binding(
            get: { selectedCountryIDs.contains(countryID) },
            set: { isSelected in
                if isSelected {
                    selectedCountryIDs.insert(countryID)
                } else {
                    selectedCountryIDs.remove(countryID)
                }
            }
        )
    }

    private func saveTrip() {
        let trip = TripPlan(
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            startDate: startDate,
            endDate: endDate,
            countryIDs: Array(selectedCountryIDs).sorted(),
            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        modelContext.insert(trip)
        dismiss()
    }
}

struct TripDetailView: View {
    let trip: TripPlan
    @Environment(\.openURL) private var openURL

    private var countries: [VignetteCountry] {
        trip.countryIDs.compactMap { CountryCatalog.country(id: $0) }
    }

    var body: some View {
        List {
            Section("Trip") {
                LabeledContent("Dates") {
                    Text("\(trip.startDate.formatted(date: .abbreviated, time: .omitted)) – \(trip.endDate.formatted(date: .abbreviated, time: .omitted))")
                }
                if !trip.notes.isEmpty {
                    Text(trip.notes)
                        .foregroundStyle(.secondary)
                }
            }

            Section("Required vignettes") {
                ForEach(countries) { country in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(country.flag)
                                .font(.title2)
                            Text(country.name)
                                .font(.headline)
                        }
                        Text(country.summary)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Button("Open official shop") {
                            openURL(country.officialShopURL)
                        }
                        .font(.subheadline)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle(trip.name)
    }
}

#Preview {
    CreateTripView()
        .modelContainer(for: TripPlan.self, inMemory: true)
}
