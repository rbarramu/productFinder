import UIKit

class Layout {
    /// Aligns `topAnchor`, `leadingAnchor`, `trailingAnchor` and `bottomAnchor` of `view` with `superview` anchors
    /// - Parameter view: View to pin
    /// - Parameter to: Superview to pin `view` in
    /// - Parameter insets: Insets to constraint the view within its superview. Default value is .zero
    class func pin(view: UIView, to superview: UIView, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(
                equalTo: superview.topAnchor,
                constant: insets.top
            ),
            view.leadingAnchor.constraint(
                equalTo: superview.leadingAnchor,
                constant: insets.left
            ),
            view.trailingAnchor.constraint(
                equalTo: superview.trailingAnchor,
                constant: -insets.right
            ),
            view.bottomAnchor.constraint(
                equalTo: superview.bottomAnchor,
                constant: -insets.bottom
            ),
        ])
    }
}
