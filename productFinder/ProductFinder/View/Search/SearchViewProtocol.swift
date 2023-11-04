import UIKit

protocol SearchViewProtocol: ActivityIndicatorPresenter {
    func showError(type: APIError)
    func goToItem(viewModel: SearchItemViewModel)
    func showLoading(status: Bool)
}
