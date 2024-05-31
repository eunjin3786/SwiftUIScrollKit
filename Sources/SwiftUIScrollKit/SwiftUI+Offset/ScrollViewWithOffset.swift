import SwiftUI

struct ScrollViewWithOffset<Content: View>: View {
    
    let items: [Content]
    let direction: Axis.Set
    let onOffsetChanged: (CGFloat) -> Void
    
    var body: some View {
        ScrollView(direction) {
            switch direction {
            case .horizontal:
                HStack(spacing: 0) {
                    contents
                }
            case .vertical:
                VStack(spacing: 0) {
                    contents
                }
            default:
                EmptyView()
            }
        }
    }
    
    var contents: some View {
        ForEach(items.indices, id: \.self) { index in
            items[index]
        }
        .overlay {
            OffsetReader(direction: direction)
        }
        .onPreferenceChange(OffsetPreferenceKey.self) {
            onOffsetChanged($0)
        }
    }
}

#Preview {
    struct Preview: View {
        let direction: Axis.Set
        @State private var offset: CGFloat = 0
        
        var body: some View {
            ScrollViewWithOffset(
                items: [
                    Color.red.frame(width: 500, height: 500),
                    Color.green.frame(width: 500, height: 500),
                    Color.yellow.frame(width: 500, height: 500),
                ],
                direction: direction,
                onOffsetChanged: {
                    offset = $0
                }
            )
            .ignoresSafeArea()
            
            Text("OFFSET: \(offset)")
        }
    }
    
    return Preview(direction: .horizontal)
}
