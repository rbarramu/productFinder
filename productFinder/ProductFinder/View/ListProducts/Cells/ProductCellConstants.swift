import UIKit

enum ProductCellConstants {
    enum Text {
        static let badgeText = "Mercado Pago"
    }

    enum StackContainer {
        static let stackContainerSpace: CGFloat = 20
        static let stackContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    enum Container {
        static let cornerRadius: CGFloat = 16.0
        static let containerViewInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
    }

    enum Image {
        static let anchorImageProductView: CGFloat = 100
    }

    enum StackViewDetail {
        static let stackSpacing: CGFloat = 4
        static let badgeFontSize: CGFloat = 16
        static let titleFontSize: CGFloat = 20
        static let originalPriceFontSize: CGFloat = 16
        static let priceFontSize: CGFloat = 20
    }
}
