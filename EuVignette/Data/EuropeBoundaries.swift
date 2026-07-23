import Foundation
import CoreLocation

struct CountryBoundary: Identifiable, Hashable {
    let id: String
    let name: String
    let requiresVignette: Bool
    let coordinates: [CLLocationCoordinate2D]

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: CountryBoundary, rhs: CountryBoundary) -> Bool {
        lhs.id == rhs.id
    }
}

private func coords(_ pairs: [(Double, Double)]) -> [CLLocationCoordinate2D] {
    pairs.map { CLLocationCoordinate2D(latitude: $0.0, longitude: $0.1) }
}

enum EuropeBoundaries {
    static let vignetteCountryIDs: Set<String> = Set(CountryCatalog.all.map(\.id))

    static let all: [CountryBoundary] = [
        // Vignette-required countries
        CountryBoundary(id: "AT", name: "Austria", requiresVignette: true, coordinates: coords([
            (47.27, 9.53), (47.59, 12.00), (48.77, 13.02), (48.98, 14.50), (48.72, 16.95),
            (48.12, 17.16), (47.06, 16.95), (46.62, 16.20), (46.40, 14.98), (46.51, 13.70),
            (46.61, 12.38), (47.05, 10.55), (47.27, 9.53)
        ])),
        CountryBoundary(id: "CH", name: "Switzerland", requiresVignette: true, coordinates: coords([
            (47.81, 7.59), (47.53, 8.52), (47.27, 9.53), (47.05, 10.55), (46.80, 10.40),
            (46.20, 8.96), (45.92, 7.05), (46.15, 6.14), (46.78, 6.02), (47.48, 6.75),
            (47.81, 7.59)
        ])),
        CountryBoundary(id: "SI", name: "Slovenia", requiresVignette: true, coordinates: coords([
            (46.55, 13.70), (46.40, 14.98), (46.62, 16.20), (46.87, 16.60), (46.55, 16.52),
            (45.78, 15.65), (45.42, 15.20), (45.47, 14.11), (45.60, 13.70), (46.00, 13.38),
            (46.55, 13.70)
        ])),
        CountryBoundary(id: "HU", name: "Hungary", requiresVignette: true, coordinates: coords([
            (48.58, 22.90), (48.58, 16.11), (47.77, 16.58), (46.72, 16.58), (46.07, 18.83),
            (45.75, 20.25), (46.22, 21.03), (46.37, 22.90), (47.95, 22.90), (48.58, 22.90)
        ])),
        CountryBoundary(id: "CZ", name: "Czech Republic", requiresVignette: true, coordinates: coords([
            (50.08, 12.10), (50.77, 14.80), (51.05, 15.02), (50.98, 16.85), (50.35, 18.85),
            (49.58, 18.85), (48.98, 17.16), (48.58, 16.95), (48.63, 6.87), (50.08, 12.10)
        ])),
        CountryBoundary(id: "SK", name: "Slovakia", requiresVignette: true, coordinates: coords([
            (49.58, 18.85), (50.35, 18.85), (50.98, 16.85), (51.05, 15.02), (50.77, 14.80),
            (50.08, 12.10), (48.63, 6.87), (48.58, 16.95), (48.98, 17.16), (49.58, 18.85)
        ])),
        CountryBoundary(id: "RO", name: "Romania", requiresVignette: true, coordinates: coords([
            (48.22, 20.22), (47.97, 22.87), (47.66, 25.00), (46.20, 28.20), (44.95, 28.60),
            (43.68, 28.05), (43.62, 27.50), (44.20, 22.70), (45.42, 20.22), (46.20, 21.00),
            (47.06, 16.95), (48.12, 17.16), (48.22, 20.22)
        ])),
        CountryBoundary(id: "BG", name: "Bulgaria", requiresVignette: true, coordinates: coords([
            (44.20, 22.70), (43.62, 27.50), (43.68, 28.05), (42.00, 27.90), (41.24, 26.10),
            (41.98, 22.50), (43.68, 22.40), (44.20, 22.70)
        ])),
        CountryBoundary(id: "MD", name: "Moldova", requiresVignette: true, coordinates: coords([
            (48.49, 26.62), (48.22, 27.65), (47.97, 28.90), (46.20, 28.20), (47.66, 25.00),
            (47.97, 22.87), (48.49, 26.62)
        ])),
        // Neighboring countries — no motorway vignette required
        CountryBoundary(id: "DE", name: "Germany", requiresVignette: false, coordinates: coords([
            (55.06, 8.50), (54.80, 13.80), (53.55, 14.70), (51.27, 15.02), (50.08, 12.10),
            (48.63, 6.87), (47.81, 7.59), (47.05, 10.55), (47.59, 12.00), (50.08, 12.10),
            (51.27, 15.02), (50.98, 16.85), (50.35, 18.85), (49.58, 18.85), (48.98, 17.16),
            (48.58, 16.95), (48.63, 6.87), (55.06, 8.50)
        ])),
        CountryBoundary(id: "PL", name: "Poland", requiresVignette: false, coordinates: coords([
            (54.80, 14.20), (54.35, 19.40), (52.35, 23.50), (49.00, 24.00), (49.58, 18.85),
            (50.98, 16.85), (51.27, 15.02), (53.55, 14.70), (54.80, 14.20)
        ])),
        CountryBoundary(id: "IT", name: "Italy", requiresVignette: false, coordinates: coords([
            (46.80, 10.40), (46.20, 8.96), (45.92, 7.05), (44.20, 7.05), (43.78, 7.52),
            (43.60, 10.50), (44.10, 12.40), (45.47, 13.70), (45.42, 15.20), (45.78, 15.65),
            (46.55, 16.52), (46.87, 16.60), (46.62, 16.20), (46.40, 14.98), (46.55, 13.70),
            (46.00, 13.38), (45.60, 13.70), (45.47, 13.70), (44.10, 12.40), (43.60, 10.50),
            (43.78, 7.52), (44.20, 7.05), (45.92, 7.05), (46.15, 6.14), (46.78, 6.02),
            (47.48, 6.75), (47.81, 7.59), (47.05, 10.55), (46.80, 10.40)
        ])),
        CountryBoundary(id: "FR", name: "France", requiresVignette: false, coordinates: coords([
            (47.48, 6.75), (46.78, 6.02), (46.15, 6.14), (45.92, 7.05), (44.20, 7.05),
            (43.78, 7.52), (43.60, 10.50), (44.10, 12.40), (43.50, 3.50), (42.35, 3.05),
            (42.70, -1.80), (43.40, -1.80), (46.20, -1.30), (48.85, -4.80), (49.70, 1.60),
            (50.95, 1.80), (51.05, 2.55), (50.95, 4.40), (50.08, 4.70), (49.55, 6.20),
            (47.48, 6.75)
        ])),
        CountryBoundary(id: "HR", name: "Croatia", requiresVignette: false, coordinates: coords([
            (46.55, 13.70), (46.00, 13.38), (45.60, 13.70), (45.47, 13.70), (44.10, 12.40),
            (43.60, 10.50), (43.78, 7.52), (44.20, 7.05), (45.42, 15.20), (45.78, 15.65),
            (46.55, 16.52), (46.55, 13.70)
        ])),
        CountryBoundary(id: "RS", name: "Serbia", requiresVignette: false, coordinates: coords([
            (46.20, 21.00), (45.42, 20.22), (44.20, 22.70), (43.68, 22.40), (41.98, 22.50),
            (42.25, 20.30), (43.20, 19.00), (44.80, 19.00), (46.20, 21.00)
        ])),
        CountryBoundary(id: "UA", name: "Ukraine", requiresVignette: false, coordinates: coords([
            (48.49, 26.62), (48.22, 27.65), (47.97, 28.90), (46.20, 28.20), (47.66, 25.00),
            (47.97, 22.87), (48.22, 20.22), (48.12, 17.16), (48.58, 16.95), (49.58, 18.85),
            (49.00, 14.80), (50.08, 12.10), (51.05, 15.02), (51.94, 14.70), (52.72, 14.50),
            (53.55, 14.70), (54.35, 14.20), (54.80, 13.80), (55.06, 8.50), (52.35, 23.50),
            (50.35, 24.00), (48.49, 26.62)
        ])),
    ]

    static func boundary(id: String) -> CountryBoundary? {
        all.first { $0.id == id }
    }
}
