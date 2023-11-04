import UIKit

final class ListProductsDataSource: NSObject {
    weak var viewController: ListProductsViewController?
    var cells: [ListProductsCellType] = ListProductsCellType.default
}

extension ListProductsDataSource: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch cells[indexPath.row] {
        case .product:
            cell = prepareProductCell(tableView: tableView, indexPath: indexPath)
            // cell.backgroundColor = .clear
        }
        return cell
    }

    private func prepareProductCell(tableView: UITableView, indexPath _: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: ProductCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ProductCell else {
            fatalError("Could not dequeue cell with identifier \(cellIdentifier)")
        }

        cell.selectionStyle = .none
        cell.setup(viewData: ProductCellViewData(title: "titulo", price: "$2.000"))
        return cell
    }
}
