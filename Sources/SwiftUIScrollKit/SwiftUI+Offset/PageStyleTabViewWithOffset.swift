import SwiftUI

public struct PageStyleTabViewWithOffset: View {
    
    public let items: [any View]
    public let onCurrentPageChanged: (Int) -> Void
    public let onOffsetChanged: (CGFloat) -> Void
    
    @State private var currentPage = 0
    
    public init(items: [any View], onCurrentPageChanged: @escaping (Int) -> Void, onOffsetChanged: @escaping (CGFloat) -> Void) {
        self.items = items
        self.onCurrentPageChanged = onCurrentPageChanged
        self.onOffsetChanged = onOffsetChanged
    }
    
    public var body: some View {
        TabView(selection: $currentPage) {
            ForEach(items.indices, id: \.self) { index in
                item(of: index)
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
    
    private func item(of index: Int) -> some View {
        let item = items[index]
        return AnyView(item)
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
