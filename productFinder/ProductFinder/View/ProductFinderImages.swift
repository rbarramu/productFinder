import UIKit

class ProductFinderImages {
    class Icons {
        class var placeholderImage: UIImage {
            icon(named: "icon-placeholder-lemon")
        }
    }

    static func icon(named: String) -> UIImage {
        if let image = UIImage(named: named) {
            return image
        }
        return UIImage()
    }
}
