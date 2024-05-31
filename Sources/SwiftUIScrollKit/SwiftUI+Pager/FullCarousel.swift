import SwiftUI

public struct FullCarousel<Content: View>: View {
    
    public let items: [Content]
    public let itemSize: CGSize

    public let onCurrentPageChanged: (Int) -> Void
    public let onOffsetChanged: (CGFloat) -> Void
    
    public init(items: [Content], itemSize: CGSize, onCurrentPageChanged: @escaping (Int) -> Void, onOffsetChanged: @escaping (CGFloat) -> Void) {
        self.items = items
        self.itemSize = itemSize
        self.onCurrentPageChanged = onCurrentPageChanged
        self.onOffsetChanged = onOffsetChanged
    }
    
    public var body: some View {
        Pager(
            items: items,
            layout: PagerLayout(
                itemSize: itemSize
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
            FullCarousel(
                items: [
                    Color.red,
                    Color.green,
                    Color.orange,
                    Color.blue
                ],
                itemSize: CGSize(width: UIScreen.main.bounds.width, height: 400),
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
