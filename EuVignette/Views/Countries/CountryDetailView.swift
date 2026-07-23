import SwiftUI

struct CountryDetailView: View {
    let country: VignetteCountry
    @Environment(\.openURL) private var openURL

    var body: some View {
        List {
            Section {
                HStack {
                    Text(country.flag)
                        .font(.system(size: 56))
                    VStack(alignment: .leading, spacing: 6) {
                        Text(country.name)
                            .font(.title2.bold())
                        Text(country.summary)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }

            Section("Vignette options") {
                ForEach(country.options) { option in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(option.label)
                                .font(.headline)
                            Spacer()
                            Text(option.price)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.blue)
                        }
                        if let notes = option.notes {
                            Text(notes)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 2)
                }
            }

            Section("Travel tips") {
                ForEach(country.tips, id: \.self) { tip in
                    Label(tip, systemImage: "lightbulb")
                        .font(.subheadline)
                }
            }

            Section("Official links") {
                Button {
                    openURL(country.officialShopURL)
                } label: {
                    Label("Buy on official portal", systemImage: "cart")
                }

                if let validityURL = country.validityCheckURL {
                    Button {
                        openURL(validityURL)
                    } label: {
                        Label("Check validity", systemImage: "checkmark.shield")
                    }
                }
            }
        }
        .navigationTitle(country.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CountryDetailView(country: CountryCatalog.all[0])
    }
}
