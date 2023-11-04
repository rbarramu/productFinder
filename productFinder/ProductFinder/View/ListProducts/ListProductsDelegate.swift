import UIKit

final class ListProductsDelegate: NSObject {}

extension ListProductsDelegate: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
