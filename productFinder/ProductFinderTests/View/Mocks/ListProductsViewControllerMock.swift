@testable import ProductFinder
import UIKit

class ListProductsViewControllerMock: ListProductsViewProtocol {
    var showErrorCalled = false
    var goToSelectedProductCalled = false
    var showLoadingCalled = false

    var activityIndicator = UIActivityIndicatorView()
    var viewModel: SearchItemViewModel?
    var searchValue: String?

    func showError(type _: APIError) {
        showErrorCalled = true
    }

    func goToSelectedProduct(itemDescriptionViewModel _: ItemDescriptionViewModel) {
        goToSelectedProductCalled = true
    }

    func showLoading(status _: Bool) {
        showLoadingCalled = true
    }

    func showActivityIndicator() {}

    func hideActivityIndicator() {}
}
