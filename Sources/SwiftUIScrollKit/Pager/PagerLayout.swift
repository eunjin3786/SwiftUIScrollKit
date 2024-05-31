import UIKit

final class PagerLayout: UICollectionViewFlowLayout {
    
    private var scrollRatio: CGFloat = 1
    private(set) var currentPage: Int = 0
    
    init(itemSize: CGSize, scrollRatio: CGFloat = 1) {
        super.init()
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 0
        self.sectionInset = .zero
        self.itemSize = itemSize
        self.scrollRatio = scrollRatio
    }
    
    init(pagerWidth: CGFloat, sectionPadding: CGFloat, cardPadding: CGFloat, height: CGFloat) {
        super.init()
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = cardPadding
        self.sectionInset = .init(top: 0, left: sectionPadding, bottom: 0, right: sectionPadding)
        
        let width = pagerWidth - sectionInset.left - sectionInset.right
        self.itemSize = CGSize(width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let pageWidth = itemSize.width + minimumLineSpacing
        let currentPage = collectionView.contentOffset.x / pageWidth
        let nearestPage = velocity.x < 0 ? floor(currentPage) : ceil(currentPage)

        self.currentPage = Int(nearestPage)
        
        let x = pageWidth * (nearestPage - 1) + pageWidth * scrollRatio
        return CGPoint(x: x, y: proposedContentOffset.y)
    }
}
