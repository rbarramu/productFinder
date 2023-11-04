import UIKit

final class ListProductsDelegate: NSObject {
    var cells: [ListProductsCellType] = ListProductsCellType.default
}

extension ListProductsDelegate: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
