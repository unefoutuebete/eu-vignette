import SwiftUI
import SwiftData

struct MyVignettesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SavedVignette.expiryDate) private var vignettes: [SavedVignette]
    @State private var showingAddSheet = false

    var body: some View {
        NavigationStack {
            Group {
                if vignettes.isEmpty {
                    ContentUnavailableView(
                        "No vignettes yet",
                        systemImage: "car.fill",
                        description: Text("Track purchased vignettes and get expiry reminders.")
                    )
                } else {
                    List {
                        ForEach(vignettes) { vignette in
                            VignetteRowView(vignette: vignette)
                        }
                        .onDelete(perform: deleteVignettes)
                    }
                }
            }
            .navigationTitle("My Vignettes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddVignetteView()
            }
        }
    }

    private func deleteVignettes(at offsets: IndexSet) {
        for index in offsets {
            NotificationManager.cancelReminder(for: vignettes[index])
            modelContext.delete(vignettes[index])
        }
    }
}

private struct VignetteRowView: View {
    let vignette: SavedVignette

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(vignette.countryFlag)
                    .font(.title2)
                Text(vignette.countryName)
                    .font(.headline)
                Spacer()
                Text(vignette.statusLabel)
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(vignette.isExpired ? Color.red.opacity(0.15) : Color.green.opacity(0.15))
                    .foregroundStyle(vignette.isExpired ? .red : .green)
                    .clipShape(Capsule())
            }

            Text(vignette.licensePlate)
                .font(.subheadline.monospaced())

            HStack {
                Label(vignette.durationLabel, systemImage: "clock")
                Spacer()
                Text("Expires \(vignette.expiryDate.formatted(date: .abbreviated, time: .omitted))")
            }
            .font(.footnote)
            .foregroundStyle(.secondary)

            if !vignette.notes.isEmpty {
                Text(vignette.notes)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    MyVignettesView()
        .modelContainer(for: SavedVignette.self, inMemory: true)
}
