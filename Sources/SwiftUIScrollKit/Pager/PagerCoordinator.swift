import SwiftUI

class PagerCoordinator<Content: View>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let items: [Content]
    var layout: PagerLayout
    
    var currentPage: Int = 0 {
        willSet {
            onCurrentPageChanged(newValue)
        }
    }
    
    let onCurrentPageChanged: (Int) -> Void
    let onOffsetChanged: (CGFloat) -> Void
    
    init(items: [Content], layout: PagerLayout, onCurrentPageChanged: @escaping (Int) -> Void, onOffsetChanged: @escaping (CGFloat) -> Void) {
        self.items = items
        self.layout = layout
        self.onCurrentPageChanged = onCurrentPageChanged
        self.onOffsetChanged = onOffsetChanged
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell<Content>.identifier, for: indexPath) as? Cell<Content>
        cell?.configure {
            items[indexPath.item]
        }
        return cell ?? UICollectionViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onOffsetChanged(scrollView.contentOffset.x)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        currentPage = min(items.count - 1, max(0, layout.currentPage))
    }
}
