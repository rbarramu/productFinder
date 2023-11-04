import UIKit

class ViewFactory {
    private let serviceLocator: ProductFinderServiceLocator

    init(serviceLocator: ProductFinderServiceLocator) {
        self.serviceLocator = serviceLocator
    }

    func viewController(type: ViewFactoryType) -> UIViewController {
        let viewController: UIViewController

        switch type {
        case .splash:
            viewController = SplashViewController()
        case .search:
            viewController = SearchViewController(
                presenter: SearchPresenter(
                    fetchProductsUseCase: serviceLocator.fetchProductsUseCase,
                    searchItemMapper: serviceLocator.fetchProductsMapper
                )
            )
        case .list:
            viewController = ListProductsViewController(
                dataSource: ListProductsDataSource(),
                delegate: ListProductsDelegate()
            )
        }

        return viewController
    }
}
