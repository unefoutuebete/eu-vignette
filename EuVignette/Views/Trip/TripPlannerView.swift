import SwiftUI
import SwiftData

struct TripPlannerView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TripPlan.createdAt, order: .reverse) private var trips: [TripPlan]
    @State private var showingCreateSheet = false

    var body: some View {
        NavigationStack {
            Group {
                if trips.isEmpty {
                    ContentUnavailableView(
                        "No trips planned",
                        systemImage: "map",
                        description: Text("Plan a route and see which vignettes you need.")
                    )
                } else {
                    List {
                        ForEach(trips) { trip in
                            NavigationLink {
                                TripDetailView(trip: trip)
                            } label: {
                                TripRowView(trip: trip)
                            }
                        }
                        .onDelete(perform: deleteTrips)
                    }
                }
            }
            .navigationTitle("Trip Planner")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingCreateSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreateSheet) {
                CreateTripView()
            }
        }
    }

    private func deleteTrips(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(trips[index])
        }
    }
}

private struct TripRowView: View {
    let trip: TripPlan

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(trip.name)
                .font(.headline)
            Text("\(trip.startDate.formatted(date: .abbreviated, time: .omitted)) – \(trip.endDate.formatted(date: .abbreviated, time: .omitted))")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(trip.countryIDs.compactMap { CountryCatalog.country(id: $0)?.flag }.joined(separator: " "))
                .font(.title3)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TripPlannerView()
        .modelContainer(for: TripPlan.self, inMemory: true)
}
