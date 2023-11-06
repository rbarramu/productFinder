import UIKit

protocol ListProductsViewProtocol: ActivityIndicatorPresenter {
    var viewModel: SearchItemViewModel? { get set }
    var searchValue: String? { get set }

    func showError(type: APIError)
    func goToSelectedProduct(itemDescriptionViewModel: ItemDescriptionViewModel)
    func showLoading(status: Bool)
}
