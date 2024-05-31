import SwiftUI

public struct RatioCarousel<Content: View>: View {
    
    public let items: [Content]
    public let itemSize: CGSize
    public let scrollRatio: CGFloat

    public let onCurrentPageChanged: (Int) -> Void
    public let onOffsetChanged: (CGFloat) -> Void
    
    public init(items: [Content], itemSize: CGSize, scrollRatio: CGFloat, onCurrentPageChanged: @escaping (Int) -> Void, onOffsetChanged: @escaping (CGFloat) -> Void) {
        self.items = items
        self.itemSize = itemSize
        self.scrollRatio = scrollRatio
        self.onCurrentPageChanged = onCurrentPageChanged
        self.onOffsetChanged = onOffsetChanged
    }

    public var body: some View {
        Pager(
            items: items,
            layout: PagerLayout(
                itemSize: itemSize,
                scrollRatio: scrollRatio
            ),
            onCurrentPageChanged: onCurrentPageChanged,
            onOffsetChanged: onOffsetChanged
        )
        .frame(height: itemSize.height)
    }
}

#Preview {
    struct Preview: View {
        
        @State var currentPage: Int = 0
        @State var offset: CGFloat = 0
        
        var body: some View {
            RatioCarousel(
                items: [
                    Color.red,
                    Color.green,
                    Color.orange,
                    Color.blue
                ].map { $0.padding(.horizontal, 5) },
                itemSize: CGSize(width: 300, height: 400),
                scrollRatio: 0.7,
                onCurrentPageChanged: {
                    currentPage = $0
                },
                onOffsetChanged: {
                    offset = $0
                }
            )
            
            Text("OFFSET: \(offset), PAGE: \(currentPage)")
        }
    }

    return Preview()
}

