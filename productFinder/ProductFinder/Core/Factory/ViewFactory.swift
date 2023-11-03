import UIKit

class ViewFactory {
    class func viewController(type: ViewFactoryType) -> UIViewController {
        let viewController: UIViewController

        switch type {
        case .splash:
            viewController = SplashViewController()
        case .search:
            viewController = SearchViewController()
        }

        return viewController
    }
}
