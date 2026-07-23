import SwiftUI

struct TimelineSliderView: View {
    @Binding var dayOffset: Double
    let startDate: Date
    let totalDays: Int
    let selectedDate: Date

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(selectedDate.formatted(.dateTime.weekday(.wide).month(.abbreviated).day().year()))
                    .font(.headline)
                Spacer()
                if dayOffset == 0 {
                    Text("Today")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.15), in: Capsule())
                        .foregroundStyle(.blue)
                }
            }

            Slider(value: $dayOffset, in: 0...Double(totalDays), step: 1)
                .tint(.blue)

            HStack {
                Text(startDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(endLabel)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
        .padding(.bottom, 8)
    }

    private var endLabel: String {
        Calendar.current.date(byAdding: .month, value: 12, to: startDate)?
            .formatted(date: .abbreviated, time: .omitted) ?? ""
    }
}

#Preview {
    TimelineSliderView(
        dayOffset: .constant(0),
        startDate: Date(),
        totalDays: 365,
        selectedDate: Date()
    )
}
