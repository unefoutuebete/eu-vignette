import SwiftUI

struct CountryListView: View {
    @State private var searchText = ""

    private var filteredCountries: [VignetteCountry] {
        guard !searchText.isEmpty else { return CountryCatalog.all }
        return CountryCatalog.all.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.id.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredCountries) { country in
                NavigationLink(value: country) {
                    HStack(spacing: 12) {
                        Text(country.flag)
                            .font(.largeTitle)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(country.name)
                                .font(.headline)
                            Text(country.summary)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(2)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Countries")
            .searchable(text: $searchText, prompt: "Search countries")
            .navigationDestination(for: VignetteCountry.self) { country in
                CountryDetailView(country: country)
            }
        }
    }
}

#Preview {
    CountryListView()
}
