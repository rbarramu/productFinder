import UIKit

extension UIView {
    /// Adds `subview` as a child of `self`
    /// - Parameter subview: A view to be added as a subview
    func addAutoLayout(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
}
