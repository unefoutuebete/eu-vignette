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

enum EuropeBoundaries {
    static let vignetteCountryIDs: Set<String> = Set(CountryCatalog.all.map(\.id))

    static let all: [CountryBoundary] = GeoJSONBoundaryLoader.load()

    static func boundary(id: String) -> CountryBoundary? {
        all.first { $0.id == id }
    }
}

enum GeoJSONBoundaryLoader {
    static func load() -> [CountryBoundary] {
        guard let url = Bundle.main.url(forResource: "europe-countries", withExtension: "geojson"),
              let data = try? Data(contentsOf: url),
              let root = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let features = root["features"] as? [[String: Any]] else {
            return []
        }

        return features.compactMap { parseFeature($0) }
            .sorted { $0.name < $1.name }
    }

    private static func parseFeature(_ feature: [String: Any]) -> CountryBoundary? {
        guard let properties = feature["properties"] as? [String: Any],
              let id = properties["id"] as? String,
              let name = properties["name"] as? String,
              let geometry = feature["geometry"] as? [String: Any],
              let type = geometry["type"] as? String else {
            return nil
        }

        let requiresVignette = properties["requiresVignette"] as? Bool ?? vignetteCountryIDs.contains(id)
        let rings = extractRings(type: type, coordinates: geometry["coordinates"])

        guard let ring = largestRing(rings), ring.count >= 3 else { return nil }

        let coordinates = ring.map { CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0]) }
        return CountryBoundary(id: id, name: name, requiresVignette: requiresVignette, coordinates: coordinates)
    }

    private static func extractRings(type: String, coordinates: Any?) -> [[[Double]]] {
        guard let coordinates else { return [] }

        switch type {
        case "Polygon":
            guard let rings = coordinates as? [[[Double]]], let outer = rings.first else { return [] }
            return [outer]
        case "MultiPolygon":
            guard let polys = coordinates as? [[[[Double]]]] else { return [] }
            return polys.compactMap { $0.first }
        default:
            return []
        }
    }

    private static func largestRing(_ rings: [[[Double]]]) -> [[Double]]? {
        rings.max(by: { $0.count < $1.count })
    }

    private static let vignetteCountryIDs = Set(CountryCatalog.all.map(\.id))
}
