import Foundation
import os

final class SearchPresenter: SearchPresenterProtocol {
    private var view: SearchViewProtocol?
    private let fetchProductsUseCase: FetchProductsUseCase
    private let searchItemMapper: Mapper<SearchItemViewModel, SearchItem>
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? Constants.empty,
        category: String(describing: SearchPresenter.self)
    )

    func attach(view: SearchViewProtocol) {
        self.view = view
    }

    init(
        fetchProductsUseCase: FetchProductsUseCase,
        searchItemMapper: Mapper<SearchItemViewModel, SearchItem>
    ) {
        self.fetchProductsUseCase = fetchProductsUseCase
        self.searchItemMapper = searchItemMapper
    }

    @MainActor
    func fetchProduct(value: String) async {
        view?.showLoading(status: true)
        do {
            logger.trace("Request product list")
            let valueFormat = value.replacingOccurrences(of: Constants.space, with: Constants.empty)
            let result = try await fetchProductsUseCase.fetch(value: valueFormat)
            let viewModel = searchItemMapper.reverseMap(value: result)
            view?.showLoading(status: false)
            logger.notice("Request product list done")
            view?.goToItem(viewModel: viewModel)
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
