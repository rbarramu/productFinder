import UIKit

protocol ProductDetailViewProtocol: ActivityIndicatorPresenter {
    var itemViewModel: ItemViewModel? { get set }
    var itemDescriptionViewModel: ItemDescriptionViewModel? { get set }

    func showError(type: APIError)
    func showLoading(status: Bool)
}
