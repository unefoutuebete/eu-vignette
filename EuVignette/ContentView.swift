import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CountryListView()
                .tabItem {
                    Label("Countries", systemImage: "globe.europe.africa")
                }

            MyVignettesView()
                .tabItem {
                    Label("Vignettes", systemImage: "car.fill")
                }

            TripPlannerView()
                .tabItem {
                    Label("Trips", systemImage: "map")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [SavedVignette.self, TripPlan.self], inMemory: true)
}
