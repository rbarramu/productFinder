import UIKit

protocol ListProductsViewProtocol: ActivityIndicatorPresenter {
    var viewModel: SearchItemViewModel? { get set }

    func showError(type: APIError)
    func goToSelectedProduct(viewModel: SearchItemViewModel)
    func showLoading(status: Bool)
}
