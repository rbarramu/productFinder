import Foundation
import os

final class ListProductsPresenter: ListProductsPresenterProtocol {
    private var view: ListProductsViewProtocol?
    private let fetchProductDetailUseCase: FetchProductDetailUseCase
    private let itemDescriptionMapper: Mapper<ItemDescriptionViewModel, ItemDescription>
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? Constants.empty,
        category: String(describing: ListProductsPresenter.self)
    )

    func attach(view: ListProductsViewProtocol) {
        self.view = view
    }

    init(
        fetchProductDetailUseCase: FetchProductDetailUseCase,
        itemDescriptionMapper: Mapper<ItemDescriptionViewModel, ItemDescription>
    ) {
        self.fetchProductDetailUseCase = fetchProductDetailUseCase
        self.itemDescriptionMapper = itemDescriptionMapper
    }

    @MainActor
    func fetchDetailProduct(id: String) async {
        view?.showLoading(status: true)
        do {
            logger.trace("Request detail product")
            let result = try await fetchProductDetailUseCase.fetch(id: id)
            let viewModel = itemDescriptionMapper.reverseMap(value: result)
            view?.showLoading(status: false)
            logger.notice("Request detail product done")
            view?.goToSelectedProduct(itemDescriptionViewModel: viewModel)
        } catch let error as APIError {
            logger.error("Error \(error)")
            view?.showLoading(status: false)
            view?.showError(type: error)
        } catch {
            logger.error("Error not identify")
            view?.showLoading(status: false)
            view?.showError(type: .defaultError)
        }
    }
}
