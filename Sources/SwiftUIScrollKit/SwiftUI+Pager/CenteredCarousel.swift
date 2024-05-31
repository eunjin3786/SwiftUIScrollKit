import SwiftUI

struct CenteredCarousel<Content: View>: View {
    
    let items: [Content]
    let pagerWidth: CGFloat
    let sectionPadding: CGFloat
    let cardPadding: CGFloat
    let height: CGFloat
    
    let onCurrentPageChanged: (Int) -> Void
    let onOffsetChanged: (CGFloat) -> Void
    
    var body: some View {
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
