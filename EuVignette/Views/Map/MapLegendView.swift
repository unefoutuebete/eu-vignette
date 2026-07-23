import SwiftUI

struct MapLegendView: View {
    var body: some View {
        HStack(spacing: 10) {
            ForEach(VignetteMapStatus.allCases, id: \.self) { status in
                HStack(spacing: 4) {
                    Circle()
                        .fill(status.color)
                        .frame(width: 8, height: 8)
                    Text(status.label)
                        .font(.caption2)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

#Preview {
    MapLegendView()
}
