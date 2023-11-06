import UIKit

final class ListProductsDataSource: NSObject {
    weak var viewController: ListProductsViewController?
}

extension ListProductsDataSource: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewController?.viewModel?.results.count ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = prepareProductCell(tableView: tableView, indexPath: indexPath)
        return cell
    }

    private func prepareProductCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: ProductCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ProductCell else {
            fatalError("Could not dequeue cell with identifier \(cellIdentifier)")
        }

        guard let viewModel = viewController?.viewModel else { return UITableViewCell() }

        let viewData = ProductCellViewData(
            title: viewModel.results[indexPath.row].title,
            price: viewModel.results[indexPath.row].price,
            originalPrice: viewModel.results[indexPath.row].originalPrice,
            thumbnail: viewModel.results[indexPath.row].thumbnail,
            placeholderImage: ProductFinderImages.Icons.placeholderImage,
            acceptsMercadopago: viewModel.results[indexPath.row].acceptsMercadopago
        )

        cell.selectionStyle = .none
        cell.setup(viewData: viewData)
        return cell
    }
}
