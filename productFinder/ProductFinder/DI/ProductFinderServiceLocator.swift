final class ProductFinderServiceLocator {
    // MARK: - Private Properties

    private var repository: ProductFinderRepository {
        ProductFinderApiRepository(restApi: restApi)
    }

    private var restApi: ProductFinderRestApi {
        ProductFinderNetworkRestApi(
            domainNetwork: domainNetwork,
            session: networkServiceLocator.session
        )
    }

    private var domainNetwork: DomainNetworkBase<Endpoint.ProductFinder> {
        ProductFinderNetwork()
    }

    private let networkServiceLocator = NetworkServiceLocator()

    // MARK: - Use Cases

    var fetchProductsUseCase: FetchProductsUseCase {
        FetchProductsUseCase(repository: repository)
    }

    // MARK: - Mappers

    var fetchProductsMapper: FetchProductsMapper {
        FetchProductsMapper()
    }
}
