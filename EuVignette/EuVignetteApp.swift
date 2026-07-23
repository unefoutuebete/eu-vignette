import SwiftUI
import SwiftData

@main
struct EuVignetteApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [SavedVignette.self, TripPlan.self])
    }
}
