import SwiftUI

struct OffsetReader: View {
    
    let direction: Axis.Set
    
    var body: some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .global)
            Color.clear
                .preference(
                    key: OffsetPreferenceKey.self,
                    value: direction == .horizontal ? frame.minX : frame.minY
                )
        }
    }
}

struct OffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: Double = 0.0
    
    static func reduce(value: inout Double, nextValue: () -> Double) {
        value += nextValue()
    }
}
