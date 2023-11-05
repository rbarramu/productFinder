import UIKit

final class ProductDetailDelegate: NSObject {
    weak var viewController: ProductDetailViewController?
}

extension ProductDetailDelegate: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
