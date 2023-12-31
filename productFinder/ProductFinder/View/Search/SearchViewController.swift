import Lottie
import os
import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Private Properties

    private let searchController = UISearchController(searchResultsController: nil)
    private let stackView = UIStackView(frame: .zero)
    private let titleLabel = UILabel()
    private let animationView = AnimationView()
    private var presenter: SearchPresenterProtocol?
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? Constants.empty,
        category: String(describing: SearchViewController.self)
    )

    // MARK: - Public Properties

    var searchValue = Constants.empty
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var errorView = ErrorView()

    // MARK: - Initialization

    convenience init(
        presenter: SearchPresenterProtocol
    ) {
        self.init()
        self.presenter = presenter
        presenter.attach(view: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationItem.title = Constants.empty
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.backgroundColor = .white
        setUpNavigationBar()
        prepareSearchController()
        prepareStackView()
        prepareAnimation()
        prepareTitle()
    }

    override func viewWillTransition(to _: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ -> Void in
            if UIWindow.isLandscape {
                self.stackView.axis = .horizontal
                self.errorView.update(axis: .horizontal)
            } else {
                self.stackView.axis = .vertical
                self.errorView.update(axis: .vertical)
            }
        }, completion: nil)
    }

    // MARK: - Private Methods

    private func setUpNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = true
        configureNavigationBar(
            largeTitleColor: .black,
            backgroundColor: Theme.current.primaryBackground,
            tintColor: .black,
            title: SearchConstants.Texts.title,
            preferredLargeTitle: true
        )
    }

    private func prepareSearchController() {
        guard searchController.searchBar.superview == nil else { return }

        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.placeholder = SearchConstants.Texts.searchBarTitle
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }

    private func prepareStackView() {
        view.addAutoLayout(subview: stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: SearchConstants.Insets.topInset
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: SearchConstants.Insets.leadingAndTrailingInset
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -SearchConstants.Insets.leadingAndTrailingInset
            ),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        stackView.axis = UIWindow.isLandscape ? .horizontal : .vertical
        stackView.spacing = SearchConstants.Insets.stackSpacing
        stackView.alignment = .center
        stackView.distribution = .fill
    }

    private func prepareAnimation() {
        stackView.addArrangedSubview(animationView)
        let path = Bundle.main.path(forResource: "SearchAnimation",
                                    ofType: "json") ?? Constants.empty
        animationView.animation = Animation.filepath(path)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalToConstant: SearchConstants.Insets.anchorInset),
            animationView.widthAnchor.constraint(equalToConstant: SearchConstants.Insets.anchorInset),
        ])
        animationView.play()
    }

    private func prepareTitle() {
        stackView.addArrangedSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = SearchConstants.Texts.informativeText
        titleLabel.font = UIFont.systemFont(ofSize: SearchConstants.fontSize, weight: .bold)
        titleLabel.numberOfLines = .zero
        titleLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: SearchConstants.Insets.anchorInset),
        ])
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange _: String) {}

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchValue = text
        errorView.removeFromSuperview()
        Task {
            await presenter?.fetchProduct(value: text)
        }
    }

    func searchBarTextDidBeginEditing(_: UISearchBar) {}

    func searchBarCancelButtonClicked(_: UISearchBar) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - SearchViewProtocol

extension SearchViewController: SearchViewProtocol {
    func showError(type: APIError) {
        errorView.removeFromSuperview()
        errorView = ErrorView()
        errorView.setup(type: type)
        errorView.delegate = self
        view.addAutoLayout(subview: errorView)
        Layout.pin(view: errorView, to: view)
    }

    func goToItem(viewModel: SearchItemViewModel) {
        errorView.removeFromSuperview()
        guard
            let viewController = ViewFactory(
                serviceLocator: ProductFinderServiceLocator()
            ).viewController(type: .listProducts) as? ListProductsViewController
        else { return }

        viewController.viewModel = viewModel
        viewController.searchValue = searchValue
        logger.trace("Push to List Products View")
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showLoading(status: Bool) {
        DispatchQueue.main.async {
            guard status else {
                self.hideActivityIndicator()
                return
            }
            self.showActivityIndicator()
        }
    }
}

// MARK: - ErrorViewDelegate

extension SearchViewController: ErrorViewDelegate {
    func didTap() {
        Task {
            await presenter?.fetchProduct(value: searchValue)
        }
    }
}
