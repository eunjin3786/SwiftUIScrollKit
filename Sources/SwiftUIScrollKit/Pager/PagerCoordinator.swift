import SwiftUI

class PagerCoordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let items: [any View]
    var layout: PagerLayout
    
    var currentPage: Int = 0 {
        willSet {
            onCurrentPageChanged(newValue)
        }
    }
    
    let onCurrentPageChanged: (Int) -> Void
    let onOffsetChanged: (CGFloat) -> Void
    
    init(items: [any View], layout: PagerLayout, onCurrentPageChanged: @escaping (Int) -> Void, onOffsetChanged: @escaping (CGFloat) -> Void) {
        self.items = items
        self.layout = layout
        self.onCurrentPageChanged = onCurrentPageChanged
        self.onOffsetChanged = onOffsetChanged
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell
        let item = items[indexPath.item]
        cell?.configure(with: item)
        return cell ?? UICollectionViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onOffsetChanged(scrollView.contentOffset.x)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        currentPage = min(items.count - 1, max(0, layout.currentPage))
    }
}
