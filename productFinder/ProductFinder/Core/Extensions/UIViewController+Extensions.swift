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
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.backgroundColor = Theme.current.primaryBackground
        activityIndicator.layer.cornerRadius = 6
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 100),
            activityIndicator.heightAnchor.constraint(equalToConstant: 100),
        ])

        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}
