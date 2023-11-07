import UIKit

final class ProductDetailDataSource: NSObject {
    weak var viewController: ProductDetailViewController?
    var cells: [ProductDetailCellType] = ProductDetailCellType.default
}

extension ProductDetailDataSource: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch cells[indexPath.row] {
        case .image:
            cell = prepareImageCell(tableView: tableView, indexPath: indexPath)
        case .title:
            cell = prepareTitleCell(tableView: tableView, indexPath: indexPath)
        case .originalPrice:
            cell = prepareOriginalPriceCell(tableView: tableView, indexPath: indexPath)
        case .price:
            cell = preparePriceCell(tableView: tableView, indexPath: indexPath)
        case .descriptionTitle:
            cell = prepareDescriptionTitleCell(tableView: tableView, indexPath: indexPath)
        case .description:
            cell = prepareDescriptionCell(tableView: tableView, indexPath: indexPath)
        }

        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }

    private func prepareImageCell(tableView: UITableView, indexPath _: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: ImageCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ImageCell else {
            fatalError("Could not dequeue cell with identifier \(cellIdentifier)")
        }

        guard let viewModel = viewController?.itemViewModel else { return UITableViewCell() }

        let viewData = ImageCellViewData(
            thumbnail: viewModel.thumbnail,
            placeholderImage: ProductFinderImages.Icons.placeholderImage
        )

        cell.setup(viewData: viewData)
        cell.accessibilityElementsHidden = true
        return cell
    }

    private func prepareTitleCell(tableView: UITableView, indexPath _: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: TitleCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TitleCell else {
            fatalError("Could not dequeue cell with identifier \(cellIdentifier)")
        }

        guard let viewModel = viewController?.itemViewModel else { return UITableViewCell() }

        let viewData = TitleCellViewData(title: viewModel.title)
        let viewStyle = TitleCellViewStyle(titleFont: UIFont.systemFont(
            ofSize: ProductDetailConstants.FontSize.title,
            weight: .regular
        ))

        cell.setup(viewData: viewData, viewStyle: viewStyle)
        return cell
    }

    private func prepareOriginalPriceCell(tableView: UITableView, indexPath _: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: TitleCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TitleCell else {
            fatalError("Could not dequeue cell with identifier \(cellIdentifier)")
        }

        guard
            let viewModel = viewController?.itemViewModel,
            let originalPrice = viewModel.originalPrice
        else { return UITableViewCell() }

        let viewData = TitleCellViewData(
            title: Formatter.format(float: originalPrice, style: .amountCLP),
            isStrikethrough: true
        )
        let viewStyle = TitleCellViewStyle(titleFont: UIFont.systemFont(
            ofSize: ProductDetailConstants.FontSize.originalPrice,
            weight: .regular
        ))

        cell.setup(viewData: viewData, viewStyle: viewStyle)
        return cell
    }

    private func preparePriceCell(tableView: UITableView, indexPath _: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: TitleCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TitleCell else {
            fatalError("Could not dequeue cell with identifier \(cellIdentifier)")
        }

        guard let viewModel = viewController?.itemViewModel else { return UITableViewCell() }

        let viewData = TitleCellViewData(title: Formatter.format(
            float: viewModel.price,
            style: .amountCLP
        ))
        let viewStyle = TitleCellViewStyle(titleFont: UIFont.systemFont(
            ofSize: ProductDetailConstants.FontSize.price,
            weight: .bold
        ))

        cell.setup(viewData: viewData, viewStyle: viewStyle)
        return cell
    }

    private func prepareDescriptionTitleCell(tableView: UITableView, indexPath _: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: TitleCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TitleCell else {
            fatalError("Could not dequeue cell with identifier \(cellIdentifier)")
        }

        guard
            let viewModel = viewController?.itemDescriptionViewModel,
            !viewModel.text.isEmpty
        else { return UITableViewCell() }

        let viewData = TitleCellViewData(title: ProductDetailConstants.Texts.descriptionTitle)
        let viewStyle = TitleCellViewStyle(titleFont: UIFont.systemFont(
            ofSize: ProductDetailConstants.FontSize.descriptionTitle,
            weight: .bold
        ))

        cell.setup(viewData: viewData, viewStyle: viewStyle)
        return cell
    }

    private func prepareDescriptionCell(tableView: UITableView, indexPath _: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: TitleCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TitleCell else {
            fatalError("Could not dequeue cell with identifier \(cellIdentifier)")
        }

        guard let viewModel = viewController?.itemDescriptionViewModel else { return UITableViewCell() }

        let viewData = TitleCellViewData(title: viewModel.text)
        let viewStyle = TitleCellViewStyle(titleFont: UIFont.systemFont(
            ofSize: ProductDetailConstants.FontSize.description,
            weight: .regular
        ))

        cell.setup(viewData: viewData, viewStyle: viewStyle)
        return cell
    }
}
