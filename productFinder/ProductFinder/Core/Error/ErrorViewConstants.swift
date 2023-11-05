import UIKit

struct ErrorViewConstants {
    enum ContainerView {
        static let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    enum ContainerStackView {
        static let spacing: CGFloat = 20
        static let topAnchorInset: CGFloat = 60
        static let anchorInsets: CGFloat = 16
    }

    enum Image {
        static let anchorInset: CGFloat = 200
    }

    enum LabelStackView {
        static let spacing: CGFloat = 10
    }

    enum Title {
        static let fontSize: CGFloat = 20
        static let widthAnchorInset: CGFloat = 300
    }

    enum Message {
        static let fontSize: CGFloat = 18
        static let widthAnchorInset: CGFloat = 300
    }

    enum Button {
        static let title = "Reintentar"
        static let widthAnchor: CGFloat = 100
        static let heightAnchor: CGFloat = 50
        static let cornerRadius: CGFloat = 8
    }

    enum StackView {
        static let spacing: CGFloat = 100
    }
}
