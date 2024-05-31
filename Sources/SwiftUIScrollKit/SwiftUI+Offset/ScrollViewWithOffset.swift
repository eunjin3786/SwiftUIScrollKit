import SwiftUI

public struct ScrollViewWithOffset<Content: View>: View {
    
    public let items: [Content]
    public let direction: Axis.Set
    public let onOffsetChanged: (CGFloat) -> Void
    
    public init(items: [Content], direction: Axis.Set, onOffsetChanged: @escaping (CGFloat) -> Void) {
        self.items = items
        self.direction = direction
        self.onOffsetChanged = onOffsetChanged
    }
    
    public var body: some View {
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
