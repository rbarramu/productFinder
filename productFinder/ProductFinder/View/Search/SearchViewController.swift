import Lottie
import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Private Properties

    private let searchController = UISearchController(searchResultsController: nil)
    private let stackView = UIStackView(frame: .zero)
    private let titleLabel = UILabel()
    private let animationView = AnimationView()
    private var presenter: SearchPresenterProtocol?

    // MARK: - Public Properties

    var searchValue = Constants.empty
    var activityIndicator = UIActivityIndicatorView(style: .large)

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
            } else {
                self.stackView.axis = .vertical
            }
        }, completion: nil)
    }

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

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = SearchConstants.Texts.searchBarTitle
        searchController.searchBar.searchTextField.backgroundColor = .white
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
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

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange _: String) {}

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchValue = text
        Task {
            await presenter?.fetchProduct(value: text)
        }
    }

    func searchBarTextDidBeginEditing(_: UISearchBar) {}

    func searchBarCancelButtonClicked(_: UISearchBar) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension SearchViewController: SearchViewProtocol {
    func showError(type _: APIError) {}

    func goToItem(viewModel: SearchItemViewModel) {
        guard
            let viewController = ViewFactory(
                serviceLocator: ProductFinderServiceLocator()
            ).viewController(type: .listProducts) as? ListProductsViewController
        else { return }

        viewController.viewModel = viewModel
        viewController.searchValue = searchValue
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
