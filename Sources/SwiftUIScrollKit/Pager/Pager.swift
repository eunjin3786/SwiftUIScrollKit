import SwiftUI

typealias Cell<Content: View> = HostingCollectionViewCell<Content>

struct Pager<Content: View>: UIViewRepresentable {
    
    let items: [Content]
    let layout: PagerLayout
    
    let onCurrentPageChanged: (Int) -> Void
    let onOffsetChanged: (CGFloat) -> Void
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .clear
        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator
        collectionView.register(Cell<Content>.self, forCellWithReuseIdentifier: Cell<Content>.identifier)
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        let shouldUpdate = (uiView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize != layout.itemSize
        if shouldUpdate {
            uiView.collectionViewLayout = layout
            context.coordinator.layout = layout
            uiView.collectionViewLayout.invalidateLayout()
            
            DispatchQueue.main.async {
                uiView.scrollToItem(at: IndexPath(item: context.coordinator.currentPage, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
    }
    
    func makeCoordinator() -> PagerCoordinator<Content> {
        PagerCoordinator<Content>(
            items: items,
            layout: layout,
            onCurrentPageChanged: onCurrentPageChanged,
            onOffsetChanged: onOffsetChanged
        )
    }
}

#Preview {
    
    struct Preview: View {
        
        @State var currentPage: Int = 0
        @State var offset: CGFloat = 0
        
        let layout: PagerLayout
        
        var body: some View {
            Pager(
                items: [
                    Color.red,
                    Color.yellow,
                    Color.green,
                    Color.blue
                ],
                layout: layout,
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
    
    return GeometryReader { proxy in
        VStack {
            Preview(
                layout: PagerLayout(itemSize: CGSize(width: proxy.size.width, height: 400))
            )
            Preview(
                layout: PagerLayout(itemSize: CGSize(width: proxy.size.width, height: 400), scrollRatio: 0.8)
            )
            Preview(
                layout: PagerLayout(pagerWidth: proxy.size.width, sectionPadding: 50, cardPadding: 20, height: 400)
            )
        }
    }
}
