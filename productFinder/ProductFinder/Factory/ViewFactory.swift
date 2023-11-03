import UIKit

class ViewFactory {
    class func viewController(type: ViewFactoryType) -> UIViewController {
        let viewController: UIViewController

        switch type {
        case .splash:
            viewController = SplashViewController()
        case .search:
            viewController = SearchViewController(presenter: SearchPresenter(
                fetchProductsUseCase: FetchProductsUseCase(
                    repository: ProductFinderApiRepository(
                        restApi: ProductFinderNetworkRestApi(domainNetwork: ProductFinderNetwork(),
                                                             session: NetworkServiceLocator().session))),
                searchItemMapper: FetchProductsMapper()
            ))
        }

        return viewController
    }
}
