import UIKit

protocol SearchViewProtocol: ActivityIndicatorPresenter {
    var value: String { get set }

    func showError(type: APIError)
    func goToItem(viewModel: SearchItemViewModel)
    func showLoading(status: Bool)
}
