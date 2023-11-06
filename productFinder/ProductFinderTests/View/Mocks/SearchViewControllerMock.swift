@testable import ProductFinder
import UIKit

class SearchViewControllerMock: SearchViewProtocol {
    var showErrorCalled = false
    var goToItemCalled = false
    var showLoadingCalled = false

    var activityIndicator = UIActivityIndicatorView()

    func showError(type _: APIError) {
        showErrorCalled = true
    }

    func goToItem(viewModel _: SearchItemViewModel) {
        goToItemCalled = true
    }

    func showLoading(status _: Bool) {
        showLoadingCalled = true
    }

    func showActivityIndicator() {}

    func hideActivityIndicator() {}
}
