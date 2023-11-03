import UIKit

extension UIViewController {
    func configureNavigationBar(
        largeTitleColor: UIColor,
        backgroundColor: UIColor,
        tintColor: UIColor,
        title: String,
        preferredLargeTitle: Bool
    ) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.backgroundColor = backgroundColor

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

            navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = tintColor
            navigationItem.title = title

        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = backgroundColor
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
    }
}

// MARK: - Activity Indicator

public protocol ActivityIndicatorPresenter {
    var activityIndicator: UIActivityIndicatorView { get }

    func showActivityIndicator()
    func hideActivityIndicator()
}

public extension ActivityIndicatorPresenter where Self: UIViewController {
    func showActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}
