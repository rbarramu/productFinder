import UIKit

protocol ListProductsViewProtocol: ActivityIndicatorPresenter {
    var viewModel: SearchItemViewModel? { get set }
    var searchValue: String? { get set }

    func showError(type: APIError)
    func goToSelectedProduct(descriptionViewModel: ItemDescriptionViewModel)
    func showLoading(status: Bool)
}
