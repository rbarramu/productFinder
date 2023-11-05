final class ListProductsPresenter: ListProductsPresenterProtocol {
    private var view: ListProductsViewProtocol?
    private let fetchProductDetailUseCase: FetchProductDetailUseCase
    private let itemDescriptionMapper: Mapper<ItemDescriptionViewModel, ItemDescription>

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
            let result = try await fetchProductDetailUseCase.fetch(id: id)
            let viewModel = itemDescriptionMapper.reverseMap(value: result)
            view?.showLoading(status: false)
            view?.goToSelectedProduct(itemDescriptionViewModel: viewModel)
        } catch let error as APIError {
            view?.showLoading(status: false)
            view?.showError(type: error)
        } catch {
            view?.showLoading(status: false)
            view?.showError(type: .defaultError)
        }
    }
}
