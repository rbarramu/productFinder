import UIKit

class ProductFinderImages {
    class Icons {
        class var placeholderImage: UIImage {
            icon(named: "icon-placeholder-lemon")
        }

        class var errorConnectionImage: UIImage {
            icon(named: "icon-error-connection")
        }

        class var errorDefaultImage: UIImage {
            icon(named: "icon-error-default")
        }

        class var errorSearchImage: UIImage {
            icon(named: "icon-error-search")
        }
    }

    static func icon(named: String) -> UIImage {
        if let image = UIImage(named: named) {
            return image
        }
        return UIImage()
    }
}
