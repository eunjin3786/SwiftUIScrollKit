import SwiftUI

struct PageStyleTabViewWithOffset<Content: View>: View {
    
    let items: [Content]
    let onCurrentPageChanged: (Int) -> Void
    let onOffsetChanged: (CGFloat) -> Void
    
    @State private var currentPage = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(items.indices, id: \.self) { index in
                items[index]
                    .tag(index)
            }
            .overlay {
                OffsetReader(direction: .horizontal)
            }
            .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                onOffsetChanged(offset)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: currentPage) {
            onCurrentPageChanged($0)
        }
    }
}

#Preview {
    
    struct Preview: View {
        
        @State private var currentPage: Int = 0
        @State private var offset: CGFloat = 0
        
        var body: some View {
            PageStyleTabViewWithOffset(
                items: [
                    Color.red,
                    Color.green,
                    Color.yellow
                ],
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
