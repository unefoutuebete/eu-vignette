import SwiftUI
import SwiftData
import MapKit

struct MapTimelineView: View {
    @Query(sort: \SavedVignette.expiryDate) private var vignettes: [SavedVignette]
    @State private var dayOffset: Double = 0
    @State private var selectedCountryID: String?
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 48.5, longitude: 17.5),
            span: MKCoordinateSpan(latitudeDelta: 14, longitudeDelta: 22)
        )
    )

    private var timelineStart: Date {
        Calendar.current.startOfDay(for: Date())
    }

    private var timelineEnd: Date {
        Calendar.current.date(byAdding: .month, value: 12, to: timelineStart) ?? timelineStart
    }

    private var totalDays: Int {
        max(Calendar.current.dateComponents([.day], from: timelineStart, to: timelineEnd).day ?? 365, 1)
    }

    private var selectedDate: Date {
        Calendar.current.date(byAdding: .day, value: Int(dayOffset.rounded()), to: timelineStart) ?? timelineStart
    }

    private var backgroundCountries: [CountryBoundary] {
        EuropeBoundaries.all.filter { !$0.requiresVignette }
    }

    private var vignetteCountries: [CountryBoundary] {
        EuropeBoundaries.all.filter { $0.requiresVignette }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Map(position: $cameraPosition, selection: $selectedCountryID) {
                    ForEach(backgroundCountries) { boundary in
                        MapPolygon(coordinates: boundary.coordinates)
                            .foregroundStyle(color(for: boundary.id).opacity(0.35))
                            .tag(boundary.id)
                    }

                    ForEach(vignetteCountries) { boundary in
                        MapPolygon(coordinates: boundary.coordinates)
                            .foregroundStyle(color(for: boundary.id).opacity(0.62))
                            .tag(boundary.id)
                    }
                }
                .mapStyle(.standard(elevation: .flat))
                .ignoresSafeArea(edges: .bottom)

                VStack(spacing: 8) {
                    MapLegendView()
                    TimelineSliderView(
                        dayOffset: $dayOffset,
                        startDate: timelineStart,
                        totalDays: totalDays,
                        selectedDate: selectedDate
                    )
                }
                .padding(.bottom, 4)
            }
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: selectedBoundaryBinding) { boundary in
                MapCountrySheet(
                    boundary: boundary,
                    selectedDate: selectedDate,
                    vignettes: vignettes
                )
                .presentationDetents([.medium])
            }
        }
    }

    private var selectedBoundaryBinding: Binding<CountryBoundary?> {
        Binding(
            get: { selectedCountryID.flatMap { EuropeBoundaries.boundary(id: $0) } },
            set: { selectedCountryID = $0?.id }
        )
    }

    private func color(for countryID: String) -> Color {
        VignetteStatusService.status(for: countryID, on: selectedDate, vignettes: vignettes).color
    }
}

private struct MapCountrySheet: View {
    let boundary: CountryBoundary
    let selectedDate: Date
    let vignettes: [SavedVignette]
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    private var status: VignetteMapStatus {
        VignetteStatusService.status(for: boundary.id, on: selectedDate, vignettes: vignettes)
    }

    private var catalogCountry: VignetteCountry? {
        CountryCatalog.country(id: boundary.id)
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 12) {
                        if let flag = catalogCountry?.flag {
                            Text(flag).font(.largeTitle)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(boundary.name)
                                .font(.title2.bold())
                            Text("On \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }

                Section("Status") {
                    Label(status.label, systemImage: "circle.fill")
                        .foregroundStyle(status.color)
                    Text(VignetteStatusService.statusSummary(for: boundary.id, on: selectedDate, vignettes: vignettes))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    if let active = VignetteStatusService.activeVignette(for: boundary.id, on: selectedDate, vignettes: vignettes) {
                        LabeledContent("License plate") {
                            Text(active.licensePlate).monospaced()
                        }
                        LabeledContent("Duration") {
                            Text(active.durationLabel)
                        }
                    }
                }

                if let country = catalogCountry, boundary.requiresVignette {
                    Section {
                        Button("Buy on official portal") {
                            openURL(country.officialShopURL)
                        }
                    }
                }
            }
            .navigationTitle(boundary.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    MapTimelineView()
        .modelContainer(for: SavedVignette.self, inMemory: true)
}
