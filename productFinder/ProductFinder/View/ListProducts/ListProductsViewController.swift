import os
import UIKit

final class ListProductsViewController: UIViewController {
    // MARK: - Private Properties

    private var dataSource: ListProductsDataSource?
    // swiftlint:disable:next weak_delegate
    private var delegate: ListProductsDelegate?
    private var presenter: ListProductsPresenterProtocol?
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? Constants.empty,
        category: String(describing: ListProductsViewController.self)
    )

    // MARK: - Public Properties

    let tableView = UITableView(frame: .zero)
    var viewModel: SearchItemViewModel?
    var selectedViewModel: ItemViewModel?
    var searchValue: String?
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var errorView = ErrorView()

    // MARK: - Initialization

    convenience init(
        dataSource: ListProductsDataSource,
        delegate: ListProductsDelegate,
        presenter: ListProductsPresenterProtocol
    ) {
        self.init()
        self.dataSource = dataSource
        self.delegate = delegate
        self.presenter = presenter
        dataSource.viewController = self
        delegate.viewController = self
        presenter.attach(view: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        registerCells()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationItem.title = Constants.empty
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationBar()
        tableView.reloadData()
    }

    override func viewWillTransition(to _: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ -> Void in
            if UIWindow.isLandscape {
                self.errorView.update(axis: .horizontal)
            } else {
                self.errorView.update(axis: .vertical)
            }
        }, completion: nil)
    }

    // MARK: - Private Methods

    private func setUpNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        configureNavigationBar(
            largeTitleColor: .black,
            backgroundColor: Theme.current.primaryBackground,
            tintColor: .black,
            title: String(format: ListProductsConstants.Texts.title, searchValue ?? Constants.empty),
            preferredLargeTitle: true
        )
    }

    private func prepareTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.backgroundColor = Theme.current.primaryLight
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = ListProductsConstants.Insets.estimatedRowHeight
        tableView.isScrollEnabled = true
        tableView.contentInset = ListProductsConstants.Insets.tableViewInsets
        view.addAutoLayout(subview: tableView)
        Layout.pin(view: tableView, to: view)
    }

    private func registerCells() {
        let productCellIdentifier = String(describing: ProductCell.self)
        tableView.register(ProductCell.self, forCellReuseIdentifier: productCellIdentifier)
    }

    // MARK: - Public Method

    func routeToDetail(indexPath: IndexPath) {
        guard let selectedItem = viewModel?.results[indexPath.row] else { return }
        selectedViewModel = selectedItem
        errorView.removeFromSuperview()
        Task {
            await presenter?.fetchDetailProduct(id: selectedItem.id)
        }
    }
}

// MARK: - ListProductsViewProtocol

extension ListProductsViewController: ListProductsViewProtocol {
    func showError(type: APIError) {
        errorView.removeFromSuperview()
        errorView = ErrorView()
        errorView.setup(type: type)
        errorView.delegate = self
        view.addAutoLayout(subview: errorView)
        Layout.pin(view: errorView, to: view)
    }

    func goToSelectedProduct(itemDescriptionViewModel: ItemDescriptionViewModel) {
        errorView.removeFromSuperview()
        guard let viewController = ViewFactory(
            serviceLocator: ProductFinderServiceLocator()
        ).viewController(type: .productDetail) as? ProductDetailViewController
        else { return }

        viewController.itemViewModel = selectedViewModel
        viewController.itemDescriptionViewModel = itemDescriptionViewModel
        logger.trace("Push to Product Detail View")
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

extension ListProductsViewController: ErrorViewDelegate {
    func didTap() {
        guard let selectedViewModel else { return }

        Task {
            await presenter?.fetchDetailProduct(id: selectedViewModel.id)
        }
    }
}
