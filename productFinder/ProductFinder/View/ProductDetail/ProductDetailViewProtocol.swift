import UIKit

protocol ProductDetailViewProtocol: ActivityIndicatorPresenter {
    var itemViewModel: ItemViewModel? { get set }
    var itemDescriptionViewModel: ItemDescriptionViewModel? { get set }

    func showLoading(status: Bool)
}
