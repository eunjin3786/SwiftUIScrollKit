import UIKit
import SwiftUI

final class HostingCollectionViewCell<Content: View>: UICollectionViewCell {
    
    static var identifier: String { "HostingCell" }
    
    private var hostingController: UIHostingController<Content>?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hostingController?.view.removeFromSuperview()
        hostingController = nil
    }
    
    func configure(@ViewBuilder _ content: () -> Content) {
        let hostingController = UIHostingController(rootView: content())
        contentView.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        self.hostingController = hostingController
    }
}
