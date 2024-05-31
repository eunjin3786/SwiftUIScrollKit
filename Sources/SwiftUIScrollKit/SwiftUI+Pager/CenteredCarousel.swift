import SwiftUI

public struct CenteredCarousel<Content: View>: View {
    
    public let items: [Content]
    public let pagerWidth: CGFloat
    public let sectionPadding: CGFloat
    public let cardPadding: CGFloat
    public let height: CGFloat

    public let onCurrentPageChanged: (Int) -> Void
    public let onOffsetChanged: (CGFloat) -> Void
    
    public init(items: [Content], pagerWidth: CGFloat, sectionPadding: CGFloat, cardPadding: CGFloat, height: CGFloat, onCurrentPageChanged: @escaping (Int) -> Void, onOffsetChanged: @escaping (CGFloat) -> Void) {
        self.items = items
        self.pagerWidth = pagerWidth
        self.sectionPadding = sectionPadding
        self.cardPadding = cardPadding
        self.height = height
        self.onCurrentPageChanged = onCurrentPageChanged
        self.onOffsetChanged = onOffsetChanged
    }

    public var body: some View {
        Pager(
            items: items,
            layout: PagerLayout(
                pagerWidth: pagerWidth,
                sectionPadding: sectionPadding,
                cardPadding: cardPadding,
                height: height
            ),
            onCurrentPageChanged: onCurrentPageChanged,
            onOffsetChanged: onOffsetChanged
        )
        .frame(height: height)
    }
}

#Preview {
    struct Preview: View {
        
        @State var currentPage: Int = 0
        @State var offset: CGFloat = 0
        
        var body: some View {
            CenteredCarousel(
                items: [
                    Color.red,
                    Color.green,
                    Color.orange,
                    Color.blue
                ],
                pagerWidth: UIScreen.main.bounds.width,
                sectionPadding: 50,
                cardPadding: 20,
                height: 300,
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
