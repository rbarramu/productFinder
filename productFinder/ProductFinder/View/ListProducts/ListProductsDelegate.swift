import UIKit

final class ListProductsDelegate: NSObject {
    weak var viewController: ListProductsViewController?
}

extension ListProductsDelegate: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController else { return }
        viewController.routeToDetail(indexPath: indexPath)
    }
}
