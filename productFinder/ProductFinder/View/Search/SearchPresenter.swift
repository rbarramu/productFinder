class SearchPresenter: SearchPresenterProtocol {
    private var view: SearchViewProtocol?
    private let fetchProductsUseCase: FetchProductsUseCase
    private let searchItemMapper: Mapper<SearchItemViewModel, SearchItem>
    var searchItem = [SearchItemViewModel]()

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
            let result = try await fetchProductsUseCase.fetch(value: value)
            let viewModel = searchItemMapper.reverseMap(value: result)

            view?.showLoading(status: false)
            view?.goToItem(viewModel: viewModel)
        } catch {
            view?.showLoading(status: false)
            view?.showError(type: error as! APIError)
        }
    }
}
